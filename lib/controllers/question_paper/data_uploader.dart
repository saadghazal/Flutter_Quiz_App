import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study_project/firebase_ref/loading_status.dart';
import 'package:flutter_study_project/firebase_ref/references.dart';
import 'package:flutter_study_project/models/question_paper_model.dart';
import 'package:get/get.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs; //loadingStatus is obs
  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading; //0
    //creating local firebase instance
    final fireStore = FirebaseFirestore.instance;

    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    //load json file and print path
    final papersInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith('assets/DB/papers') && path.contains('.json'),)
        .toList();
    List<QuestionPaperModel> questionPapers = [];
    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionPapers.add(
        QuestionPaperModel.fromJson(
          jsonDecode(stringPaperContent),
        ),
      );
    }
    print(questionPapers[0].id);
    // print('${questionPapers[0].description}');
    var batch = fireStore.batch();
    for (var paper in questionPapers) {
      batch.set(
        questionPaperRF.doc(paper.id),
        {
          'title': paper.title,
          'image_url': paper.imageUrl,
          'description': paper.description,
          'time_seconds': paper.timeSeconds,
          'questions_count':
              paper.questions == null ? 0 : paper.questions!.length,
        },
      );
      for (var questions in paper.questions!) {
        final questionPath = questionRF(
          paperId: paper.id,
          questionId: questions.id,
        );
        batch.set(
          questionPath,
          {
            'question': questions.question,
            'correct_answer': questions.correctAnswer,
          },
        );
        for (var answers in questions.answers) {
          final answerPath = answerRF(
            paperId: paper.id,
            questionId: questions.id,
            answerID: answers.identifier!,
          );
          batch.set(
            answerPath,
            {
              "identifier": answers.identifier,
              "answer": answers.answer,
            },
          );
        }
      }
    }
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}

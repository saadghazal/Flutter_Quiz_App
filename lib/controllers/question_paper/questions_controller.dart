import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_study_project/controllers/question_paper/question_paper_controller.dart';
import 'package:flutter_study_project/firebase_ref/loading_status.dart';
import 'package:flutter_study_project/firebase_ref/references.dart';
import 'package:flutter_study_project/models/question_paper_model.dart';
import 'package:flutter_study_project/screens/home/home_screen.dart';
import 'package:flutter_study_project/screens/question/result_screen.dart';
import 'package:get/get.dart';

class QuestionsController extends GetxController {
  late QuestionPaperModel questionPaperModel;
  final allQuestions = <Questions>[];
  final loadingStatus = LoadingStatus.loading.obs;
  final questionIndex = 0.obs;
  bool get isFirstQuestion => questionIndex.value > 0;
  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;
  Rxn<Questions> currentQuestion = Rxn<Questions>();
  Timer? _timer;
  int remainSeconds = 1;
  final time = '00.00'.obs;

  @override
  void onReady() {
    final _questionPaper = Get.arguments as QuestionPaperModel;
    print('...OnReady...');
    loadData(_questionPaper);
    super.onReady();
  }

  Future<void> loadData(QuestionPaperModel questionPaper) async {
    questionPaperModel = questionPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await questionPaperRF
              .doc(questionPaperModel.id)
              .collection('questions')
              .get();
      final questions = questionQuery.docs
          .map((snapshot) => Questions.fromSnapshot(snapshot))
          .toList();
      questionPaper.questions = questions;
      for (Questions _question in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await questionPaperRF
                .doc(questionPaper.id)
                .collection('questions')
                .doc(_question.id)
                .collection('answers')
                .get();
        final answers = answersQuery.docs
            .map((answer) => Answers.fromSnapshot(answer))
            .toList();
        _question.answers = answers;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (questionPaper.questions != null &&
        questionPaper.questions!.isNotEmpty) {
      allQuestions.assignAll(questionPaper.questions!);
      currentQuestion.value = questionPaper.questions![0];
      _startTimer(questionPaper.timeSeconds);
      loadingStatus.value = LoadingStatus.completed;
      print('...StartTimer...');
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectAnswer(String? answer) {
    print('hi');
    currentQuestion.value!.selectedAnswer = answer;
    update(
      ['answers_list', 'answer_review_list'],
    );
  }

  String get completedTest {
    final answered = allQuestions
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return '$answered out of ${allQuestions.length} answered';
  }

  void jumpToQuestion(int index, {bool isGoBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestions[questionIndex.value];
    if (isGoBack) {
      Get.back();
    }
  }

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) {
      return;
    }
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  void prevQuestion() {
    if (questionIndex.value <= 0) {
      return;
    }
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        if (remainSeconds == 0) {
          timer.cancel();
        } else {
          int minutes = remainSeconds ~/ 60;
          int seconds = remainSeconds % 60;
          time.value =
              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
          remainSeconds--;
        }
      },
    );
  }

  void complete() {
    _timer!.cancel();
    Get.offAndToNamed(ResultScreen.routeName);
  }

  void tryAgain() {
    Get.find<QuestionPaperController>().navigateToQuestions(
      paper: questionPaperModel,
      tryAgain: true,
    );
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.offNamedUntil(HomeScreen.routeName, (route) => false);
  }
}

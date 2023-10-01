import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_study_project/controllers/auth_controller.dart';
import 'package:flutter_study_project/firebase_ref/references.dart';
import 'package:flutter_study_project/screens/question/questions_screen.dart';
import 'package:flutter_study_project/services/firebase_storage_service.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/question_paper_model.dart';

class QuestionPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPapers = <QuestionPaperModel>[].obs;
  @override
  void onReady() {
    getAllPapers();
    // TODO: implement onReady
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = [
      'biology',
      'chemistry',
      'maths',
      'physics',
    ];
    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();

      final paperList = data.docs.map((paper) {
        return QuestionPaperModel.fromSnapshot(paper);
      }).toList();
      allPapers.assignAll(paperList);
      for (var paper in paperList) {
        final imgUrl =
            await Get.find<FirebaseStorageService>().getImage(paper.title);
        paper.imageUrl = imgUrl;
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      print('hi');
      print(e);
    }
  }

  void navigateToQuestions({
    required QuestionPaperModel paper,
    bool tryAgain = false,
  }) {
    AuthController _authController = Get.find();
    if (_authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();
        Get.toNamed(
          QuestionsScreen.routeName,
          arguments: paper,
          preventDuplicates: false,
        );
      } else {
        print('hi');
        Get.toNamed(QuestionsScreen.routeName, arguments: paper);
      }
    } else {
      _authController.showLoginAlertDialog();
    }
  }
}

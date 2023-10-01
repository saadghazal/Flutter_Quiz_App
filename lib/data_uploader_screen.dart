import 'package:flutter/material.dart';
import 'package:flutter_study_project/controllers/question_paper/data_uploader.dart';
import 'package:flutter_study_project/firebase_ref/loading_status.dart';
import 'package:get/get.dart';

class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({Key? key}) : super(key: key);
  DataUploader dataUploaderController = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => Text(
            dataUploaderController.loadingStatus.value ==
                    LoadingStatus.completed
                ? 'Uploading Completed'
                : 'Uploading...',
          ),
        ),
      ),
    );
  }
}

import 'package:flutter_study_project/controllers/auth_controller.dart';
import 'package:flutter_study_project/controllers/theme_controller.dart';
import 'package:get/get.dart';

import '../services/firebase_storage_service.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
    Get.put(FirebaseStorageService());
  }
}

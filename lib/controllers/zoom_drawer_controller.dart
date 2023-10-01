import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_study_project/controllers/auth_controller.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyZoomDrawerController extends GetxController {
  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  Rxn<User?> user = Rxn();
  final zoomDrawerController = ZoomDrawerController();
  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {}
  void website() {
    _launch('https://www.dbestech.com');
  }

  void facebook() {
    _launch('https://www.facebook.com');
  }

  void email() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@dbestech.com',
    );
    _launch(emailLaunchUri.toString());
  }

  Future<void> _launch(String url) async {
    if (!await launch(url)) {
      throw 'could not launch $url';
    }
  }
}

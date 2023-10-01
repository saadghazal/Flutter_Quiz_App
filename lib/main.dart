import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_project/bindings/initial_bindings.dart';
import 'package:flutter_study_project/controllers/theme_controller.dart';
import 'package:flutter_study_project/firebase_options.dart';
import 'package:flutter_study_project/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Get.find<ThemeController>().lightTheme,
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      getPages: AppRoutes.routes(),
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(
//     GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DataUploaderScreen(),
//     ),
//   );
// }

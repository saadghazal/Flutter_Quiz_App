import 'package:flutter_study_project/controllers/question_paper/question_paper_controller.dart';
import 'package:flutter_study_project/controllers/question_paper/questions_controller.dart';
import 'package:flutter_study_project/controllers/zoom_drawer_controller.dart';
import 'package:flutter_study_project/screens/home/home_screen.dart';
import 'package:flutter_study_project/screens/login/login_screen.dart';
import 'package:flutter_study_project/screens/question/check_answer_screen.dart';
import 'package:flutter_study_project/screens/question/questions_screen.dart';
import 'package:flutter_study_project/screens/question/result_screen.dart';
import 'package:flutter_study_project/screens/question/test_overview_screen.dart';
import 'package:flutter_study_project/screens/splash/app_introduction_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screens/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/introduction',
          page: () => const AppIntroductionScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          binding: BindingsBuilder(
            () {
              Get.put<QuestionPaperController>(QuestionPaperController());
              Get.put<MyZoomDrawerController>(MyZoomDrawerController());
            },
          ),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: QuestionsScreen.routeName,
          binding: BindingsBuilder(() {
            Get.put<QuestionsController>(QuestionsController());
          }),
          page: () => QuestionsScreen(),
        ),
        GetPage(
          name: TestOverviewScreen.routeName,
          page: () => TestOverviewScreen(),
        ),
        GetPage(
          name: ResultScreen.routeName,
          page: () => ResultScreen(),
        ),
        GetPage(
          name: CheckAnswerScreen.routeName,
          page: () => CheckAnswerScreen(),
        ),
      ];
}

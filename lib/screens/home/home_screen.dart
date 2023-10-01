import 'package:flutter/material.dart';
import 'package:flutter_study_project/configs/themes/app_colors.dart';
import 'package:flutter_study_project/configs/themes/app_icons.dart';
import 'package:flutter_study_project/configs/themes/custom_styles.dart';
import 'package:flutter_study_project/configs/themes/ui_parameters.dart';
import 'package:flutter_study_project/controllers/question_paper/question_paper_controller.dart';
import 'package:flutter_study_project/controllers/zoom_drawer_controller.dart';
import 'package:flutter_study_project/screens/home/menu_screen.dart';
import 'package:flutter_study_project/screens/home/question_card.dart';
import 'package:flutter_study_project/widgets/content_area.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../widgets/app_circle_button.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    QuestionPaperController questionPaperController = Get.find();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(builder: (_) {
        return ZoomDrawer(
          style: DrawerStyle.DefaultStyle,
          borderRadius: 50,
          showShadow: true,
          angle: 0,
          controller: _.zoomDrawerController,
          backgroundColor: Colors.white.withOpacity(0.5),
          slideWidth: MediaQuery.of(context).size.width * 0.6,
          menuScreen: MyMenuScreen(),
          mainScreen: Container(
              decoration: BoxDecoration(
                gradient: mainGradient(),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(mobileScreenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppCircleButton(
                            onTap: controller.toggleDrawer,
                            child: Icon(
                              AppIcons.menuLeft,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const Icon(
                                  AppIcons.peace,
                                ),
                                Text(
                                  'Hello Friend',
                                  style: detailText.copyWith(
                                    color: onSurfaceTextColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            'What do you want to learn today?',
                            style: headerText,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ContentArea(
                          addPadding: false,
                          child: Obx(() {
                            return ListView.separated(
                              padding: UIParameters.mobileScreenPadding,
                              itemBuilder: (context, index) {
                                return QuestionCard(
                                  model:
                                      questionPaperController.allPapers[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                              itemCount:
                                  questionPaperController.allPapers.length,
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      }),
    );
  }
}

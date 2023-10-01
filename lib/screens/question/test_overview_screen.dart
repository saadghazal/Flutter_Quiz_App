import 'package:flutter/material.dart';
import 'package:flutter_study_project/configs/themes/app_colors.dart';
import 'package:flutter_study_project/configs/themes/app_dark_theme.dart';
import 'package:flutter_study_project/controllers/question_paper/questions_controller.dart';
import 'package:flutter_study_project/widgets/common/background_decoration.dart';
import 'package:flutter_study_project/widgets/common/custom_app_bar.dart';
import 'package:flutter_study_project/widgets/common/main_button.dart';
import 'package:flutter_study_project/widgets/content_area.dart';
import 'package:flutter_study_project/widgets/questions/answer_card.dart';
import 'package:flutter_study_project/widgets/questions/question_number_card.dart';
import 'package:get/get.dart';

import '../../configs/themes/custom_styles.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../widgets/questions/countdown_timer.dart';

class TestOverviewScreen extends GetView<QuestionsController> {
  const TestOverviewScreen({Key? key}) : super(key: key);
  static const routeName = '/test-overview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.completedTest,
      ),
      body: BackgroundDecoration(
        showGradient: true,
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CountdownTimer(
                          color: UIParameters.isDarkMode()
                              ? Theme.of(context).textTheme.bodyText1!.color
                              : Theme.of(context).primaryColor,
                          time: '',
                        ),
                        Obx(
                          () => Text(
                            '${controller.time} Remaining',
                            style: countDownTimeTS(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: controller.allQuestions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (_, index) {
                          AnswerStatus? answerStatus;
                          if (controller.allQuestions[index].selectedAnswer !=
                              null) {
                            answerStatus = AnswerStatus.answered;
                          }
                          return QuestionNumberCard(
                            index: index + 1,
                            status: answerStatus,
                            onTap: () {
                              controller.jumpToQuestion(index);
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: Get.isDarkMode
                  ? primaryDarkColorDark
                  : Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: MainButton(
                  color: Get.isDarkMode ? primaryColorDark : onSurfaceTextColor,
                  onTap: () {
                    controller.complete();
                  },
                  title: 'Complete',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

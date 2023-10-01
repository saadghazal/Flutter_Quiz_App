import 'package:flutter/material.dart';
import 'package:flutter_study_project/configs/themes/app_dark_theme.dart';
import 'package:flutter_study_project/configs/themes/custom_styles.dart';
import 'package:flutter_study_project/controllers/question_paper/questions_controller.dart';
import 'package:flutter_study_project/firebase_ref/loading_status.dart';
import 'package:flutter_study_project/screens/question/test_overview_screen.dart';
import 'package:flutter_study_project/widgets/common/background_decoration.dart';
import 'package:flutter_study_project/widgets/common/custom_app_bar.dart';
import 'package:flutter_study_project/widgets/common/question_place_holder.dart';
import 'package:flutter_study_project/widgets/content_area.dart';
import 'package:flutter_study_project/widgets/questions/answer_card.dart';
import 'package:flutter_study_project/widgets/questions/countdown_timer.dart';
import 'package:get/get.dart';

import '../../configs/themes/app_colors.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../widgets/common/main_button.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  const QuestionsScreen({Key? key}) : super(key: key);
  static const routeName = '/questions';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Container(
          decoration: const ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide(color: onSurfaceTextColor, width: 2),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Obx(() {
            return CountdownTimer(
              time: controller.time.value,
              color: onSurfaceTextColor,
            );
          }),
        ),
        showActionIcon: true,
        titleWidget: Obx(
          () {
            return Text(
              'Q ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
              style: appBarTS,
            );
          },
        ),
      ),
      body: BackgroundDecoration(
        showGradient: true,
        child: Obx(
          () {
            final currentQuestion = controller.currentQuestion;
            return Column(
              children: [
                if (controller.loadingStatus.value == LoadingStatus.loading)
                  const Expanded(
                    child: ContentArea(child: QuestionScreenHolder()),
                  ),
                if (controller.loadingStatus.value == LoadingStatus.completed)
                  Expanded(
                    child: ContentArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Text(
                              currentQuestion.value!.question,
                              style: questionTS,
                            ),
                            GetBuilder<QuestionsController>(
                              id: 'answers_list',
                              builder: (context) {
                                return ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 25),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final answer = controller
                                        .currentQuestion.value!.answers[index];
                                    return AnswerCard(
                                      answer:
                                          '${answer.identifier}. ${answer.answer}',
                                      onTap: () {
                                        controller.selectAnswer(
                                          answer.identifier,
                                        );
                                      },
                                      isSelected: answer.identifier ==
                                          controller.currentQuestion.value!
                                              .selectedAnswer,
                                    );
                                  },
                                  separatorBuilder: (context, _) =>
                                      const SizedBox(
                                    height: 10,
                                  ),
                                  itemCount: controller
                                      .currentQuestion.value!.answers.length,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ColoredBox(
                  color: Get.isDarkMode
                      ? primaryDarkColorDark
                      : Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: UIParameters.mobileScreenPadding,
                    child: Row(
                      children: [
                        Visibility(
                          visible: controller.isFirstQuestion,
                          child: SizedBox(
                            width: 55,
                            height: 55,
                            child: MainButton(
                              color: Get.isDarkMode
                                  ? primaryColorDark
                                  : onSurfaceTextColor,
                              onTap: () {
                                controller.prevQuestion();
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Get.isDarkMode
                                    ? onSurfaceTextColor
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        controller.isFirstQuestion
                            ? SizedBox(
                                width: 10,
                              )
                            : Container(),
                        Expanded(
                          child: Visibility(
                            visible: controller.loadingStatus.value ==
                                LoadingStatus.completed,
                            child: MainButton(
                              color: Get.isDarkMode
                                  ? primaryColorDark
                                  : onSurfaceTextColor,
                              title: controller.isLastQuestion
                                  ? 'Complete'
                                  : 'Next',
                              onTap: () {
                                controller.isLastQuestion
                                    ? Get.toNamed(TestOverviewScreen.routeName)
                                    : controller.nextQuestion();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

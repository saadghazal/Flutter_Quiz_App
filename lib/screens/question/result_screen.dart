import 'package:flutter/material.dart';
import 'package:flutter_study_project/configs/themes/app_colors.dart';
import 'package:flutter_study_project/configs/themes/custom_styles.dart';
import 'package:flutter_study_project/configs/themes/ui_parameters.dart';
import 'package:flutter_study_project/controllers/question_paper/questions_controller.dart';
import 'package:flutter_study_project/controllers/question_paper/questions_controller_extension.dart';
import 'package:flutter_study_project/screens/question/check_answer_screen.dart';
import 'package:flutter_study_project/widgets/common/background_decoration.dart';
import 'package:flutter_study_project/widgets/common/custom_app_bar.dart';
import 'package:flutter_study_project/widgets/common/main_button.dart';
import 'package:flutter_study_project/widgets/content_area.dart';
import 'package:flutter_study_project/widgets/questions/answer_card.dart';
import 'package:flutter_study_project/widgets/questions/question_number_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({Key? key}) : super(key: key);
  static const routeName = '/result';

  @override
  Widget build(BuildContext context) {
    Color textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          title: controller.correctAnsweredQuestions,
        ),
        body: BackgroundDecoration(
          showGradient: true,
          child: Column(
            children: [
              Expanded(
                child: ContentArea(
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/images/bulb.svg'),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 5,
                        ),
                        child: Text(
                          'Congratulations',
                          style: headerText.copyWith(
                            color: textColor,
                          ),
                        ),
                      ),
                      Text(
                        'You have ${controller.points} points',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Tap below question numbers to view correct answers',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.allQuestions.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Get.width ~/ 75,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (_, index) {
                            print('index : $index');
                            final question = controller.allQuestions[index];
                            AnswerStatus status = AnswerStatus.notAnswered;
                            final selectedAnswer = question.selectedAnswer;
                            final correctAnswer = question.correctAnswer;
                            if (selectedAnswer == correctAnswer) {
                              status = AnswerStatus.correct;
                            } else if (question.selectedAnswer == null) {
                              status = AnswerStatus.wrong;
                            } else {
                              status = AnswerStatus.wrong;
                            }
                            return QuestionNumberCard(
                              index: index + 1,
                              status: status,
                              onTap: () {
                                controller.jumpToQuestion(
                                  index,
                                  isGoBack: false,
                                );
                                Get.toNamed(CheckAnswerScreen.routeName);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: Row(
                    children: [
                      Expanded(
                        child: MainButton(
                          onTap: () {
                            controller.tryAgain();
                          },
                          color: Colors.blueGrey,
                          title: 'Try Again',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MainButton(
                          color: Get.isDarkMode
                              ? Theme.of(context).primaryColor
                              : onSurfaceTextColor,
                          onTap: () {
                            controller.saveTestResult();
                          },
                          title: 'Go Home',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_study_project/controllers/question_paper/questions_controller.dart';
import 'package:flutter_study_project/screens/question/result_screen.dart';
import 'package:flutter_study_project/widgets/common/background_decoration.dart';
import 'package:flutter_study_project/widgets/common/custom_app_bar.dart';
import 'package:flutter_study_project/widgets/content_area.dart';
import 'package:flutter_study_project/widgets/questions/answer_card.dart';
import 'package:get/get.dart';

import '../../configs/themes/custom_styles.dart';

class CheckAnswerScreen extends GetView<QuestionsController> {
  const CheckAnswerScreen({Key? key}) : super(key: key);
  static const routeName = '/check-answer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          () => Text(
            'Q ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
            style: appBarTS,
          ),
        ),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(ResultScreen.routeName);
        },
      ),
      body: BackgroundDecoration(
        showGradient: true,
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: ContentArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(controller.currentQuestion.value!.question),
                        SizedBox(
                          height: 20,
                        ),
                        GetBuilder<QuestionsController>(
                          id: 'answer_review_list',
                          builder: (_) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final answer = controller
                                    .currentQuestion.value!.answers[index];
                                final selectedAnswer = controller
                                    .currentQuestion.value!.selectedAnswer;
                                final correctAnswer = controller
                                    .currentQuestion.value!.correctAnswer;
                                final String answerText =
                                    '${answer.identifier}. ${answer.answer}';
                                if (correctAnswer == selectedAnswer &&
                                    answer.identifier == selectedAnswer) {
                                  //correct answer
                                  return CorrectAnswer(answer: answerText);
                                } else if (selectedAnswer == null) {
                                  //not selected Answer
                                  return NotAnswered(answer: answerText);
                                } else if (correctAnswer != selectedAnswer &&
                                    answer.identifier == selectedAnswer) {
                                  //wrong answer
                                  return WrongAnswer(answer: answerText);
                                } else if (correctAnswer == answer.identifier) {
                                  //correct answer
                                  return CorrectAnswer(answer: answerText);
                                }
                                return AnswerCard(
                                  answer: answerText,
                                  onTap: () {},
                                );
                              },
                              separatorBuilder: (_, index) => const SizedBox(
                                height: 10,
                              ),
                              itemCount: controller
                                  .currentQuestion.value!.answers.length,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

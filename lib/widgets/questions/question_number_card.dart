import 'package:flutter/material.dart';
import 'package:flutter_study_project/configs/themes/app_colors.dart';
import 'package:flutter_study_project/configs/themes/ui_parameters.dart';
import 'package:flutter_study_project/widgets/questions/answer_card.dart';
import 'package:get/get.dart';

class QuestionNumberCard extends StatelessWidget {
  const QuestionNumberCard({
    Key? key,
    required this.index,
    required this.status,
    required this.onTap,
  }) : super(key: key);
  final int index;
  final AnswerStatus? status;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;
    switch (status) {
      case AnswerStatus.correct:
        backgroundColor = correctAnswerColor;
        // TODO: Handle this case.
        break;
      case AnswerStatus.wrong:
        backgroundColor = wrongAnswerColor;
        // TODO: Handle this case.
        break;
      case AnswerStatus.answered:
        backgroundColor = Theme.of(context).primaryColor;
        // TODO: Handle this case.
        break;
      case AnswerStatus.notAnswered:
        backgroundColor = Get.isDarkMode
            ? Colors.red.withOpacity(0.5)
            : Theme.of(context).primaryColor.withOpacity(0.1);
        // TODO: Handle this case.
        break;
      default:
        backgroundColor = Theme.of(context).primaryColor.withOpacity(0.1);
    }
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: UIParameters.cardBorderRadius,
        ),
        child: Center(
          child: Text(
            '$index',
            style: TextStyle(
              color: status == AnswerStatus.notAnswered
                  ? Theme.of(context).primaryColor
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

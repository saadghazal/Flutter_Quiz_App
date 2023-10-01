import 'package:flutter/material.dart';
import 'package:flutter_study_project/configs/themes/app_colors.dart';
import 'package:flutter_study_project/configs/themes/app_dark_theme.dart';
import 'package:flutter_study_project/configs/themes/ui_parameters.dart';
import 'package:get/get.dart';

enum AnswerStatus {
  correct,
  wrong,
  answered,
  notAnswered,
}

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    required this.answer,
    this.isSelected = false,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: isSelected
              ? answerSelectedColor()
              : Get.isDarkMode
                  ? primaryColorDark
                  : Theme.of(context).cardColor,
          border: Border.all(
            color: isSelected ? answerSelectedColor() : answerBorderColor(),
          ),
        ),
        child: Text(
          answer,
          style: TextStyle(
            color: isSelected ? onSurfaceTextColor : null,
          ),
        ),
      ),
    );
  }
}

class CorrectAnswer extends StatelessWidget {
  const CorrectAnswer({
    required this.answer,
    Key? key,
  }) : super(key: key);
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: correctAnswerColor.withOpacity(0.1),
      ),
      child: Text(
        answer,
        style: const TextStyle(
          color: correctAnswerColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class WrongAnswer extends StatelessWidget {
  const WrongAnswer({
    required this.answer,
    Key? key,
  }) : super(key: key);
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: wrongAnswerColor.withOpacity(0.1),
      ),
      child: Text(
        answer,
        style: const TextStyle(
          color: wrongAnswerColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class NotAnswered extends StatelessWidget {
  const NotAnswered({
    required this.answer,
    Key? key,
  }) : super(key: key);
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: notAnsweredColor.withOpacity(0.1),
      ),
      child: Text(
        answer,
        style: const TextStyle(
          color: notAnsweredColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

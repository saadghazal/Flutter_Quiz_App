import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_project/configs/themes/app_light_theme.dart';
import 'package:flutter_study_project/configs/themes/ui_parameters.dart';
import 'package:get/get.dart';

import 'app_dark_theme.dart';

const Color onSurfaceTextColor = Colors.white;
const Color correctAnswerColor = Color(0xFF3ac3cb);
const Color wrongAnswerColor = Color(0xFFf65187);
const Color notAnsweredColor = Color(0xFF2a3c65);
const mainGradiantLight = LinearGradient(
  colors: [
    primaryLightColorLight,
    primaryColorLight,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const mainGradiantDark = LinearGradient(
  colors: [
    primaryDarkColorDark,
    primaryColorDark,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
LinearGradient mainGradient() =>
    UIParameters.isDarkMode() ? mainGradiantDark : mainGradiantLight;
customScaffoldColor(BuildContext context) => UIParameters.isDarkMode()
    ? const Color(0xFF2e3c62)
    : const Color.fromARGB(255, 240, 237, 255);
Color answerSelectedColor() => UIParameters.isDarkMode()
    ? primaryColorDark.withOpacity(0.2)
    : Theme.of(Get.context!).primaryColor;

Color answerBorderColor() => UIParameters.isDarkMode()
    ? const Color.fromARGB(255, 20, 46, 158)
    : const Color.fromARGB(255, 221, 221, 221);

import 'package:flutter/material.dart';
import 'package:flutter_study_project/configs/themes/app_colors.dart';
import 'package:flutter_study_project/widgets/app_circle_button.dart';
import 'package:get/get.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: mainGradient(),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                size: 65,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'This is a study app you can use it as you want.If you understand how it works you would be able to scale it.With this you will master firebase backend and flutter front end.',
                style: TextStyle(
                  fontSize: 18,
                  color: onSurfaceTextColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              AppCircleButton(
                child: Icon(
                  Icons.arrow_forward,
                  size: 30,
                  color: Colors.white,
                ),
                onTap: () => Get.offAllNamed('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

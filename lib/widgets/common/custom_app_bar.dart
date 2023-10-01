import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_project/configs/themes/app_icons.dart';
import 'package:flutter_study_project/configs/themes/custom_styles.dart';
import 'package:flutter_study_project/configs/themes/ui_parameters.dart';
import 'package:flutter_study_project/screens/question/test_overview_screen.dart';
import 'package:flutter_study_project/widgets/app_circle_button.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.title = '',
    this.showActionIcon = false,
    this.leading,
    this.titleWidget,
    this.onMenuActionTap,
    Key? key,
  }) : super(key: key);
  final String title;
  final Widget? titleWidget;
  final bool showActionIcon;
  final Widget? leading;
  final VoidCallback? onMenuActionTap;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mobileScreenPadding,
          vertical: mobileScreenPadding,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: titleWidget == null
                  ? Center(
                      child: Text(
                        title,
                        style: appBarTS,
                      ),
                    )
                  : Center(
                      child: titleWidget,
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leading ??
                    Transform.translate(
                      offset: const Offset(-14, 0),
                      child: const BackButton(),
                    ),
                if (showActionIcon)
                  Transform.translate(
                    offset: const Offset(0, 0),
                    child: AppCircleButton(
                      onTap: onMenuActionTap ??
                          () => Get.toNamed(TestOverviewScreen.routeName),
                      child: Icon(
                        AppIcons.menu,
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 80);
}

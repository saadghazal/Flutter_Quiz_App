import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_project/configs/themes/app_colors.dart';
import 'package:flutter_study_project/configs/themes/ui_parameters.dart';
import 'package:flutter_study_project/controllers/zoom_drawer_controller.dart';
import 'package:get/get.dart';

class MyMenuScreen extends GetView<MyZoomDrawerController> {
  const MyMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIParameters.mobileScreenPadding,
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: mainGradient(),
      ),
      child: Theme(
        data: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: onSurfaceTextColor),
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    controller.toggleDrawer();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.3,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => controller.user.value == null
                          ? const SizedBox()
                          : Text(
                              controller.user.value!.displayName ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: onSurfaceTextColor,
                              ),
                            ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    _DrawerButton(
                      label: 'website',
                      icon: Icons.web,
                      onTap: () => controller.website(),
                    ),
                    _DrawerButton(
                      label: 'facebook',
                      icon: Icons.facebook,
                      onTap: () => controller.facebook(),
                    ),

                    // padding: const EdgeInsets.only(left: 25),
                    _DrawerButton(
                      label: 'email',
                      icon: Icons.email,
                      onTap: () => controller.email(),
                    ),
                    Spacer(
                      flex: 4,
                    ),
                    _DrawerButton(
                      label: 'logout',
                      icon: Icons.logout,
                      onTap: () => controller.signOut(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton({
    required this.label,
    required this.icon,
    this.onTap,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      label: Text(label),
      icon: Icon(
        icon,
        size: 15,
      ),
    );
  }
}

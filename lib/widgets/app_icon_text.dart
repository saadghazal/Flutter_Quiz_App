import 'package:flutter/cupertino.dart';

class AppIconText extends StatelessWidget {
  final Icon icon;
  final Widget text;
  const AppIconText({required this.icon, required this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 4,
        ),
        text,
      ],
    );
  }
}

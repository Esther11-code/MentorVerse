
import 'package:flutter/material.dart';

import '../../../../../globalwidget/export.dart';

class SignupOrLogin extends StatelessWidget {
  const SignupOrLogin(
      {super.key, required this.title, required this.subTitle, this.ontap});
  final String title, subTitle;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      AppText(text: '$title '),
      GestureDetector(
          onTap: ontap,
          child: AppText(text: subTitle, fontweight: FontWeight.w600))
    ]);
  }
}

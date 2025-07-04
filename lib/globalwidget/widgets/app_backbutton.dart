
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/export.dart';
import '../export.dart';

class AppbackButton extends StatelessWidget {
  const AppbackButton({
    super.key,
    this.onTap,
  });
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return AppshadowContainer(
        padding: EdgeInsets.all(3.h),
        shadowcolour: Appcolors.lightgrey,
        onTap: onTap ?? () => Navigator.pop(context),
        child: Icon(Icons.chevron_left_outlined, size: 30.sp));
  }
}

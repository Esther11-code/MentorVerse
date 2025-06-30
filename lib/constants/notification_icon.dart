
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/page route/detail/route_name.dart';
import '../globalwidget/export.dart';
import 'export.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return AppshadowContainer(
        shadowcolour: Appcolors.lightgrey,
        padding: EdgeInsets.all(2.w),
        onTap: () => Navigator.pushNamed(context, RouteName.notification),
        child: Icon(Icons.notifications, size: 25.sp));
  }
}

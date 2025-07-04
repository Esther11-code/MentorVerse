
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:google_fonts/google_fonts.dart';

import 'appcolors.dart';

class CraftmanTimer extends StatelessWidget {
  const CraftmanTimer(
      {super.key, required this.duration, this.timerColor, this.onEnd});
  final int duration;
  final Color? timerColor;
  final Function()? onEnd;

  @override
  Widget build(BuildContext context) {
    return TimerCountdown(
        onEnd: onEnd,
        spacerWidth: 1,
        colonsTextStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: timerColor ?? Appcolors.redColor),
        timeTextStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: timerColor ?? Appcolors.redColor),
        format: CountDownTimerFormat.minutesSeconds,
        enableDescriptions: false,
        endTime: DateTime.now().add(Duration(minutes: duration)));
  }
}

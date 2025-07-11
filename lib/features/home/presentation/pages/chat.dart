

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/export.dart';
import '../../../../globalwidget/export.dart';
import '../widget/export.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AppScaffold(
        color: Appcolors.blue,
        body: Column(
          children: [
            SizedBox(height: size.height * 0.01),
            const CustomAppbar(title: 'Chats'),
            SizedBox(height: size.height * 0.015),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                width: size.width,
                color: Appcolors.white,
                child: Column(
                  children: [
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: size.width * 0.73,
                            child:
                                HomeTextfield(size: size, hintext: 'Message')),
                        Transform.rotate(
                            angle: 1.6,
                            child: Icon(CupertinoIcons.location_circle_fill,
                                color: Appcolors.blue, size: 60.sp))
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

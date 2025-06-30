
import 'package:flutter/material.dart';
import '../../../../constants/export.dart';
import '../../../../globalwidget/export.dart';
import '../widget/export.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    // final watchHome = context.watch<HomeCubit>();
    final size = MediaQuery.sizeOf(context);
    return AppScaffold(
      
        color: Appcolors.white,
        body: Column(children: [
          const CustomAppbar(title: 'All Services'),
          SizedBox(height: size.height * 0.02),
          Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.width * 0.02),
                  color: Appcolors.white,
                  width: size.width,
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: size.width * 0.03,
                      mainAxisSpacing: size.width * 0.03,
                      children: List.generate(
                          10,
                          (index) =>
                              CategorieContainer(index: index, size: size)))))
        ]));
  }
}

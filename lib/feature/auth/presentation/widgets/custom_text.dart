import 'package:flutter/material.dart';

import '../../../../core/constant/colorsHelper.dart';
import '../../../../core/constant/fontsHelper.dart';

class CustomText extends StatelessWidget {
  final double ?fontSize;
  final FontWeight ?fontWeight;
  Color ?color;
  final VoidCallback? callback;
  final String title;
  Alignment ?alignment;
  CustomText({super.key,  this.fontSize,  this.fontWeight, required this.title,this.alignment,this.color, this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        alignment: alignment,
        child: Text(
          title,style: TextStyle(
            color: color?? ColorsHelper.blackColor,
            fontSize: fontSize??FontHelper.font_18,
            fontWeight: fontWeight??FontHelper.bold
        ),
        ),
      ),
    );
  }
}

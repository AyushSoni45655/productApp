import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_application/core/constant/assetsHelper.dart';

import '../../../../core/constant/colorsHelper.dart';
import '../../../../core/constant/dimensionHelper.dart';
import '../../../../core/constant/fontsHelper.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final String title;
  final String? text;
  final bool socialBool;
  final double? fontsize;
  final FontWeight? fontWeight;
  final VoidCallback? callback;
  const CustomButton(
      {super.key,
      this.color,
      required this.title,
      this.text,
      this.fontsize,
      this.fontWeight,
      this.callback,
      this.socialBool = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        height: DimensionHelper.dimens_45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DimensionHelper.dimens_12),
            color: title == text
                ? ColorsHelper.blackColor
                : ColorsHelper.transparent,
            border: title != text
                ? Border.all(width: 1.2, color: ColorsHelper.blackColor)
                : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           socialBool? Image(
                height: DimensionHelper.dimens_20.h,
                width: DimensionHelper.dimens_20.w,
                image: AssetImage(
                  AssetsHelper.google,
                )):SizedBox(),
            SizedBox(width: DimensionHelper.dimens_20.w,),
            Text(
              title,
              style: TextStyle(
                  color: title == text
                      ? ColorsHelper.whiteColor
                      : ColorsHelper.blackColor,
                  fontWeight: FontHelper.bold,
                  fontSize: DimensionHelper.dimens_16),
            ),
          ],
        ),
      ),
    );
  }
}

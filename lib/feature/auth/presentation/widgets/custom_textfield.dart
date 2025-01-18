
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colorsHelper.dart';
import '../../../../core/constant/dimensionHelper.dart';

class CustomTextField extends StatelessWidget {
  final bool hide;
  final TextInputType ?inputType;
  final String ?levelText;
  final String ?hintText;
  final IconData? prefixIcon;
  final Widget ?suffixIcon;
  final TextEditingController ?controller;
  final String? Function(String?) ?validatore;
  const CustomTextField({super.key, this.hide = false, this.inputType, this.levelText, this.hintText, this.prefixIcon, this.suffixIcon,  this.controller, this.validatore});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DimensionHelper.dimens_50.h,
      child: TextFormField(
        keyboardType:   inputType,
        obscureText: hide,
        validator: validatore,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: levelText,
            prefixIcon: Icon(prefixIcon,size: DimensionHelper.dimens_24,color: ColorsHelper.blackColor,),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DimensionHelper.dimens_15)
            )
        ),
      ),
    );
  }
}

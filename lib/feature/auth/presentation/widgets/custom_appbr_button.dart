import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_application/core/constant/colorsHelper.dart';
import 'package:products_application/core/constant/dimensionHelper.dart';

class CustomAppBarButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback ?callback;
  const CustomAppBarButton({super.key, required this.iconData, this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:callback,
      child: Container(
       // padding: EdgeInsets.all(DimensionHelper.dimens_12.sp),
        height: DimensionHelper.dimens_50.h,
        width: DimensionHelper.dimens_45.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DimensionHelper.dimens_12.r),
          color: ColorsHelper.greyColor
        ),
        child: Center(child: Icon(iconData,size: 30.sp,),),
      ),
    );
  }
}

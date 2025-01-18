import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_application/core/constant/dimensionHelper.dart';

class CustomGrid extends StatelessWidget {
  final double ?height;
  final int itemCount;
  final Widget Function(BuildContext ,int) itemBuilder;
  const CustomGrid({super.key, this.height, required this.itemCount, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 270,
            crossAxisSpacing: DimensionHelper.dimens_10.sp,
            mainAxisSpacing: DimensionHelper.dimens_10.sp,
          ),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: itemCount,
          primary: true,
          scrollDirection: Axis.vertical,
          itemBuilder: itemBuilder
      ),
    );
  }
}

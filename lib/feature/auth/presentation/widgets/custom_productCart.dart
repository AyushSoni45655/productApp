import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_application/core/constant/dimensionHelper.dart';
import 'package:products_application/core/constant/fontsHelper.dart';

class CustomSingleProductCart extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final VoidCallback delete;
  final String dscription;
  final VoidCallback? callback;

  const CustomSingleProductCart(
      {super.key,
      required this.image,
      required this.title,
      required this.dscription,
      required this.price,
      this.callback, required this.delete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.all(DimensionHelper.dimens_6.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DimensionHelper.dimens_12.r),
            color: Colors.grey
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children:[ Container(
                height: DimensionHelper.dimens_130.h,
                width: DimensionHelper.dimens_150.w,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius:
                        BorderRadius.circular(DimensionHelper.dimens_8.r),
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(image))),
              ),
                Positioned(
                  left: DimensionHelper.dimens_120,
                    child: IconButton(onPressed: () {
                      delete();
                    }, icon: Icon(Icons.delete_rounded,color: Colors.red,size: 30,)))
              ]
            ),
            SizedBox(
              height: DimensionHelper.dimens_4,
            ),
            Text(title,
                style: TextStyle(
                  fontSize: FontHelper.font_14,
                  fontWeight: FontWeight.bold
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
            SizedBox(
              height: DimensionHelper.dimens_4,
            ),
            Text(
              dscription,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,

              maxLines: 3,
            ),
            SizedBox(
              height: DimensionHelper.dimens_4,
            ),
            Text(
              price,
              style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}

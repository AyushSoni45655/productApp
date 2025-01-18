import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_application/core/constant/colorsHelper.dart';
import 'package:products_application/core/constant/dimensionHelper.dart';
import 'package:products_application/core/constant/fontsHelper.dart';
import 'package:products_application/core/constant/stringHelper.dart';
import 'package:products_application/core/constant/validation.dart';
import 'package:products_application/core/utils/utility.dart';
import 'package:products_application/feature/auth/domain/entity/product.dart';
import 'package:products_application/feature/auth/presentation/blocs/product/products_bloc.dart';
import 'package:products_application/feature/auth/presentation/widgets/custom_button.dart';
import 'package:products_application/feature/auth/presentation/widgets/custom_text.dart';
import 'package:products_application/feature/auth/presentation/widgets/custom_textfield.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late TextEditingController imageCon;
  late TextEditingController titleCon;
  late TextEditingController descriptionCon;
  late TextEditingController priceCon;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    imageCon = TextEditingController();
    titleCon = TextEditingController();
    descriptionCon = TextEditingController();
    priceCon = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    imageCon.dispose();
    priceCon.dispose();
    titleCon.dispose();
    descriptionCon.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsHelper.greyColor,
        elevation: 1,
        title: Text(
          "Add Products",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(DimensionHelper.dimens_15.sp),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: DimensionHelper.dimens_80,),
                CustomText(title: StringHelper.aPDetails,fontWeight: FontWeight.bold,color: ColorsHelper.nBlue,fontSize: FontHelper.font_26,),
                SizedBox(
                  height: DimensionHelper.dimens_50.h,
                ),
                CustomTextField(
                  prefixIcon: Icons.title,
                  inputType: TextInputType.name,
                  hide: false,
                  validatore: (value) {
                    return AValidator.validateEmptyText(StringHelper.tLavel, value);
                  },
                  controller: titleCon,
                  levelText: StringHelper.tLavel,
                  hintText: StringHelper.tHint,
                ),
                SizedBox(
                  height: DimensionHelper.dimens_24.h,
                ),
                CustomTextField(
                  prefixIcon: Icons.description,
                  inputType: TextInputType.name,
                  hide: false,
                  validatore: (value) {
                    return AValidator.validateEmptyText(
                        StringHelper.dLavel, value);
                  },
                  controller: descriptionCon,
                  levelText: StringHelper.dLavel,
                  hintText: StringHelper.dHint,
                ),
                SizedBox(
                  height: DimensionHelper.dimens_24.h,
                ),
                CustomTextField(
                  prefixIcon: Icons.price_change,
                  inputType: TextInputType.number,
                  hide: false,
                  validatore: (value) {
                    return AValidator.validateEmptyText(
                        StringHelper.pLevel, value);
                  },
                  controller: priceCon,
                  levelText: StringHelper.prLavel,
                  hintText: StringHelper.prHint,
                ),
                SizedBox(
                  height: DimensionHelper.dimens_24.h,
                ),
                CustomTextField(
                  prefixIcon: Icons.photo,
                  inputType: TextInputType.name,
                  hide: false,
                  validatore: (value) {
                    return AValidator.validateEmptyText(
                        StringHelper.iLavel, value);
                  },
                  controller: imageCon,
                  levelText: StringHelper.iLavel,
                  hintText: StringHelper.iHint,
                ),
                SizedBox(
                  height: DimensionHelper.dimens_50.h,
                ),
                CustomButton(
                  title: StringHelper.aProduct,
                  text: StringHelper.aProduct,
                  fontWeight: FontWeight.bold,
                  fontsize: FontHelper.font_24,
                  callback: () {
                    if(formKey.currentState!.validate()){
                      final product = Product(
                          productTitle: titleCon.text.trim(),
                          productdescription: descriptionCon.text.trim(),
                          productPrice: priceCon.text.trim(),
                          productImage: imageCon.text.trim()
                      );
                      context.read<ProductsBloc>().add(saveProductEvent(product: product));
                      Utils().toastMessage("Product Added Succssfully");
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

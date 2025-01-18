import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_application/core/constant/colorsHelper.dart';
import 'package:products_application/core/constant/dimensionHelper.dart';
import 'package:products_application/core/constant/fontsHelper.dart';
import 'package:products_application/core/constant/helper_funcction.dart';
import 'package:products_application/core/constant/stringHelper.dart';
import 'package:products_application/core/utils/utility.dart';
import 'package:products_application/feature/auth/presentation/blocs/authentication/login_bloc.dart';
import 'package:products_application/feature/auth/presentation/blocs/product/products_bloc.dart';
import 'package:products_application/feature/auth/presentation/widgets/custom_appbr_button.dart';
import 'package:products_application/feature/auth/presentation/widgets/custom_grid.dart';
import 'package:products_application/feature/auth/presentation/widgets/custom_productCart.dart';
import 'package:products_application/feature/auth/presentation/widgets/custom_searchdelegate.dart';
import 'package:products_application/feature/auth/presentation/widgets/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addProduct');
        },
        child: Icon(
          Icons.add,
          size: DimensionHelper.dimens_30.sp,
          color: ColorsHelper.nBlue,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                context.read<LoginBloc>().add(LogOutEvent());
                Navigator.pushReplacementNamed(context, "/");
              },
              icon: Icon(
                Icons.logout,
                size: 30,
                color: ColorsHelper.nBlue,
              )),
          SizedBox(width: DimensionHelper.dimens_15.w,),

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(DimensionHelper.dimens_12.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAppBarButton(
                      iconData: Icons.arrow_back_ios_new_sharp,
                  ),
                  CustomAppBarButton(iconData: Icons.search,callback: () {
                    showSearch(context: context, delegate: ProductSearchDelegte());
                  },)
                ],
              ),
              SizedBox(height: DimensionHelper.dimens_30.h,),
              CustomText(title: StringHelper.hTitle,fontSize: FontHelper.font_30,fontWeight: FontWeight.bold,alignment: Alignment.centerLeft,),
              SizedBox(height: DimensionHelper.dimens_6.h,),
              CustomText(title: StringHelper.hSTitle1,fontSize: FontHelper.font_14,alignment: Alignment.centerLeft,color: Colors.grey,),
              SizedBox(height: DimensionHelper.dimens_4.h,),
              CustomText(title: StringHelper.hSTitle2,fontSize: FontHelper.font_14,alignment: Alignment.centerLeft,color:Colors.grey,),
              SizedBox(height: DimensionHelper.dimens_30.h,),
              // Products grid view
              BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if(state is ProductLoding){
                    Center(child: CircularProgressIndicator(color: Colors.green,),);
                  }
                  else if(state is Productrror){
                    Utils().toastMessage(state.error.toString());
                  }
                  else if(state is ProductLoaded){
                    if(state.products.isEmpty){
                     return Center(child: Text('No Products found',style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 14
                     ),),);
                    }
                    return CustomGrid(
                      itemCount: state.products.length,
                      itemBuilder: (_, index) {
                        final products = state.products[index];
                        return CustomSingleProductCart(
                          delete: () {
                            AHelperFunction.showAlert("Are you Sure you want to delete??", () {
                              context.read<ProductsBloc>().add(delelteProductEvent(title: products.productTitle));
                              Navigator.pop(context);
                            },context);
                          },
                          callback: () {

                          },
                           title: products.productTitle,
                          price: "\$${products.productPrice}.00"??'No Image',
                          dscription: products.productdescription,
                          image: products.productImage,
                        );
                      },
                    );
                  }
                  return Center(child: Text('No Products Found',style: TextStyle(color: Colors.green),),);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

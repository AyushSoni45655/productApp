import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_application/core/utils/utility.dart';
import 'package:products_application/feature/auth/presentation/blocs/product/products_bloc.dart';

import '../../../../core/constant/helper_funcction.dart';
import 'custom_grid.dart';
import 'custom_productCart.dart';

class ProductSearchDelegte extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(onPressed: (){
        query = '';
      }, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    context.read<ProductsBloc>().add(filterProductEvent(query:query));
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (context, state) {
      if(state is ProductLoding){
        Center(child: CircularProgressIndicator(color: Colors.red,),);
      }
      else if(state is Productrror){
        Utils().toastMessage(state.error.toString());
      }
      else if(state is ProductLoaded){
        return CustomGrid(
          itemCount: state.products.length,
          itemBuilder: (_, index) {
            final products = state.products[index];
            return CustomSingleProductCart(
              delete: () {
                AHelperFunction.showAlert("Are you Sure you want to delete??", () {

                },context);
              },
              callback: () {

              },
              title: products.productTitle,
              price: "\$${products.productPrice}.00",
              dscription: products.productdescription,
              image: products.productImage,
            );
          },
        );
      }
      return Container();
    },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('No Data found'),);
  }
}

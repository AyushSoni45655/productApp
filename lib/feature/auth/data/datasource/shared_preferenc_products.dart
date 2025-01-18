import 'dart:convert';

import 'package:products_application/feature/auth/data/modal/product_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceDataSource{
  final SharedPreferences prefs;
  static const String productKey = "products";
  SharedPreferenceDataSource({required this.prefs});
  Future<void>saveProduct(ProductModal product)async{
    final products = await getProducts();
    products.add(product);
    final  productmap = products.map((e) => e.toMap(),).toList();
    await prefs.setString(productKey, json.encode(productmap));
  }
  Future<List<ProductModal>>getProducts()async{
    final productstring = prefs.getString(productKey);
    if(productstring == null)return [];
    final productList = json.decode(productstring)as List<dynamic>;
    return productList.map((map)=>ProductModal.fromJson(map)).toList();
  }
  Future<List<ProductModal>>filterProduct(String query)async{
    final products = await getProducts();
    return products.where((element) => element.productTitle.toLowerCase().contains(query.toLowerCase()),).toList();

  }
  Future<void>deleteProduct(String title)async{
    final products = await getProducts();
    products.removeWhere((element) => element.productTitle == title,);
    final productmap = products.map((e) => e.toMap(),).toList();
    await prefs.setString(productKey, json.encode(productmap));
  }
}
import 'package:products_application/feature/auth/domain/entity/product.dart';
import 'package:products_application/feature/auth/domain/repositry/product_repositry.dart';

class FilterProductUseCase{
  final ProductRepositry productRepositry;
  FilterProductUseCase({required this.productRepositry});
  Future<List<Product>>call(String query){
    return productRepositry.filterProduct(query);
  }
}
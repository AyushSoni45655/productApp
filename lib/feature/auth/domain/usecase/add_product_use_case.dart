import 'package:products_application/feature/auth/domain/entity/product.dart';
import 'package:products_application/feature/auth/domain/repositry/product_repositry.dart';

class AddProductUseCase{
  final ProductRepositry productRepositry;
  AddProductUseCase({required this.productRepositry});
  Future<void>call(Product product){
    return productRepositry.saveProduct(product);
  }
}
import 'package:products_application/feature/auth/domain/entity/product.dart';
import 'package:products_application/feature/auth/domain/repositry/product_repositry.dart';

class GetProductUseCase{
  ProductRepositry productRepositry;
  GetProductUseCase({required this.productRepositry});
  Future<List<Product>>call(){
    return productRepositry.getProduct();
  }
}
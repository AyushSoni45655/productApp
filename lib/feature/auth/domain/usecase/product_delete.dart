import 'package:products_application/feature/auth/domain/repositry/product_repositry.dart';

class ProdutDeleteUseCase{
  final ProductRepositry productRepositry;
  ProdutDeleteUseCase({required this.productRepositry});
  Future<void>call(String title){
    return productRepositry.deleteProduct(title);
  }
}
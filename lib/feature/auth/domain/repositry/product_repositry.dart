import 'package:products_application/feature/auth/domain/entity/product.dart';

abstract class ProductRepositry{
  Future<void>saveProduct(Product product);
  Future<void>deleteProduct(String title);
  Future<List<Product>>getProduct();
  Future<List<Product>>filterProduct(String query);
}
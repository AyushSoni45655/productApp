import 'package:products_application/feature/auth/data/datasource/shared_preferenc_products.dart';
import 'package:products_application/feature/auth/data/modal/product_modal.dart';
import 'package:products_application/feature/auth/domain/entity/product.dart';
import 'package:products_application/feature/auth/domain/repositry/product_repositry.dart';

class ProductRepoImpl extends ProductRepositry{
  final SharedPreferenceDataSource sharedPreferenceDataSource;
  ProductRepoImpl({required this.sharedPreferenceDataSource});
  @override
  Future<void> deleteProduct(String title)async {
    await sharedPreferenceDataSource.deleteProduct(title);
  }

  @override
  Future<List<Product>> filterProduct(String query)async {
    final productmodl = await sharedPreferenceDataSource.filterProduct(query);
    return productmodl.map((e) => Product(
        productTitle: e.productTitle,
        productdescription: e.productdescription,
        productPrice: e.productPrice,
        productImage: e.productImage),).toList();
  }

  @override
  Future<List<Product>> getProduct() async{
    final products = await sharedPreferenceDataSource.getProducts();
    return products.map((e) => Product(
        productTitle: e.productTitle,
        productdescription: e.productdescription,
        productPrice: e.productPrice,
        productImage: e.productImage
    ),).toList();
  }

  @override
  Future<void> saveProduct(Product product) async{
    final prductmodal = ProductModal(
        image: product.productImage,
        title: product.productTitle,
        description: product.productdescription,
        price: product.productPrice
    );
    await sharedPreferenceDataSource.saveProduct(prductmodal);
  }
  
}
import 'package:products_application/feature/auth/domain/entity/product.dart';

class ProductModal extends Product {
  ProductModal(
      {required String image,
      required String title,
      required String description,
      required String price})
      : super(
            productdescription: description,
            productImage: image,
            productPrice: price,
            productTitle: title);
  //tomap function
Map<String,dynamic>toMap(){
  return{
    'Image':productImage,
    'Title':productTitle,
    'Description':productdescription,
    'Price':productPrice
  };
}
// fromjson function
factory ProductModal.fromJson(Map<String,dynamic>map){
  return ProductModal(
      image: map['Image']??'No image',
      title: map['Title']??'No Title',
      description: map['Description']??'No des...',
      price: map['Price']??'No price'
  );
}
}

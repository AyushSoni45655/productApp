part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}
class delelteProductEvent extends ProductsEvent{
  final String title;
  delelteProductEvent({required this.title});
}
class filterProductEvent extends ProductsEvent{
  final String query;
  filterProductEvent({required this.query});
}
class saveProductEvent extends ProductsEvent{
  final Product product;
  saveProductEvent({required this.product});
}
class getProductEvent extends ProductsEvent{

}
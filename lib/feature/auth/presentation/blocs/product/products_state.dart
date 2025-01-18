part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}
final class ProductLoding extends ProductsState{}
final class Productrror extends ProductsState{
  final String error;
  Productrror({required this.error});
}
final class ProductLoaded extends ProductsState{
  List<Product> products;
  ProductLoaded({required this.products});
}
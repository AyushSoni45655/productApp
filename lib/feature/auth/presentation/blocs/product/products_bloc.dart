import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:products_application/feature/auth/domain/entity/product.dart';
import 'package:products_application/feature/auth/domain/usecase/add_product_use_case.dart';
import 'package:products_application/feature/auth/domain/usecase/filter_product_use_case.dart';
import 'package:products_application/feature/auth/domain/usecase/get_product.dart';
import 'package:products_application/feature/auth/domain/usecase/product_delete.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProdutDeleteUseCase produtDeleteUseCase;
  final GetProductUseCase getProductUseCase;
  final FilterProductUseCase filterProductUseCase;
  final AddProductUseCase addProductUseCase;
  ProductsBloc(
      {required this.addProductUseCase,
      required this.filterProductUseCase,
      required this.getProductUseCase,
      required this.produtDeleteUseCase})
      : super(ProductsInitial()) {
    on<delelteProductEvent>((event, emit) async {
      try {
        await produtDeleteUseCase(event.title);
        add(getProductEvent());
      } catch (e) {
        emit(Productrror(error: "filed to delete product${e.toString()}"));
      }
    });
    on<filterProductEvent>(
      (event, emit)async {
        emit(ProductLoding());
        try {
         final produt =  await filterProductUseCase(event.query);
          emit(ProductLoaded(products: produt));
        } catch (e) {
          emit(Productrror(error: "failed to search product${e.toString()}"));
        }
      },
    );
    on<saveProductEvent>(
      (event, emit) async{
        try{
          await addProductUseCase(event.product);
          add(getProductEvent());
        }catch(e){
          emit(Productrror(error: "failed to save product${e.toString()}"));
        }
      },
    );
    on<getProductEvent>(
      (event, emit) async{
        emit(ProductLoding());
        try{
          final product = await getProductUseCase();
          emit(ProductLoaded(products: product));
        }catch(e){
          emit(Productrror(error: 'failed to load products${e.toString()}'));
        }
      },
    );
  }
}

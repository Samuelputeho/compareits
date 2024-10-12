import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:product_repository/product_repository.dart';

part 'get_product_event.dart';
part 'get_product_state.dart';

class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  final ProductRepo _productRepo;

  GetProductBloc(this._productRepo) : super(GetProductInitial()) {
    on<GetProduct>((event, emit) async {
      emit(GetProductLoading());
      try {
        // Fetch products with store, category, and search query filters
        List<Product> products = await _productRepo.getProducts(
          store: event.store,
          category: event.category,
          searchQuery: event.searchQuery, // Use the search query
        );
        emit(GetProductSuccess(products));
      } catch (e) {
        emit(GetProductFailure(message: e.toString()));
      }
    });
  }
}

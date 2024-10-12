part of 'get_product_bloc.dart';

sealed class GetProductEvent extends Equatable {
  const GetProductEvent();

  @override
  List<Object> get props => [];
}

class GetProduct extends GetProductEvent {
  final String? store; // Add store parameter
  final String? category; // Ensure this is defined
  final String? searchQuery; // Add searchQuery parameter

  const GetProduct(
      {this.store,
      this.category,
      this.searchQuery}); // Constructor with named parameters

  @override
  List<Object> get props => [
        store ?? '',
        category ?? '',
        searchQuery ?? ''
      ]; // Ensure non-nullable types
}

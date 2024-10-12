import 'models/models.dart';

abstract class ProductRepo {
  // Add optional searchQuery parameter to support filtering
  Future<List<Product>> getProducts(
      {String? store, String? category, String? searchQuery});
}

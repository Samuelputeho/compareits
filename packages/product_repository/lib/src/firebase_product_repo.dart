import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_repository/product_repository.dart';

class FirebaseProductRepo extends ProductRepo {
  final productsCollection = FirebaseFirestore.instance.collection('products');

  @override
  Future<List<Product>> getProducts(
      {String? store, String? category, String? searchQuery}) async {
    try {
      Query query = productsCollection;

      // Apply filters if store and category are provided
      if (store != null) {
        query = query.where('shop', isEqualTo: store);
      }
      if (category != null) {
        query = query.where('category', isEqualTo: category);
      }

      // Fetch products from the database
      QuerySnapshot snapshot = await query.get();

      // Convert Firestore document snapshots to Product objects
      List<Product> products = snapshot.docs.map((e) {
        final data =
            e.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
        if (data == null) {
          throw Exception("Document data is null");
        }

        // Safely handle numeric data for product properties
        data['quantity'] = (data['quantity'] as num?)?.toDouble() ?? 0.0;
        data['price'] = (data['price'] as num?)?.toDouble() ?? 0.0;
        data['salePrice'] = (data['salePrice'] as num?)?.toDouble() ?? 0.0;

        // Return Product from Firestore data
        return Product.fromEntity(ProductEntity.fromDocument(data));
      }).toList();

      // Apply search query filter if provided
      if (searchQuery != null && searchQuery.isNotEmpty) {
        products = products.where((product) {
          return product.name.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();
      }

      return products;
    } catch (e) {
      print('Error fetching products: $e');
      log(e.toString());
      rethrow;
    }
  }
}

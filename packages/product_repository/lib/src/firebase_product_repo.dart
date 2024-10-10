import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_repository/product_repository.dart';

class FirebaseProductRepo extends ProductRepo {
  final productsCollection = FirebaseFirestore.instance.collection('products');

  @override
  Future<List<Product>> getProducts() async {
    try {
      return await productsCollection.get().then((value) => value.docs.map((e) {
            final data = e.data();
            // Convert integer values to doubles
            data['quantity'] = (data['quantity'] as num).toDouble();
            data['price'] = (data['price'] as num).toDouble();
            data['salePrice'] = (data['salePrice'] as num).toDouble();
            return Product.fromEntity(ProductEntity.fromDocument(data));
          }).toList());
    } catch (e) {
      print('error message: $e');
      log(e.toString());
      rethrow;
    }
  }
}

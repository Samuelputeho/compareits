import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_repository/product_repository.dart';

class FirebaseProductRepo extends ProductRepo {
  final productsCollection = FirebaseFirestore.instance.collection('products');

  Future<List<Product>> getProducts() async {
    try {
      return await productsCollection.get().then((value) => value.docs
          .map((e) => Product.fromEntity(ProductEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

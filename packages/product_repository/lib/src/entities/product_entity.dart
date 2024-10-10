class ProductEntity {
  double quantity;
  String name;
  String productId;
  String picture;
  String description;
  String category;
  String shop;
  double price;
  double salePrice;

  ProductEntity(
      {required this.quantity,
      required this.productId,
      required this.name,
      required this.picture,
      required this.description,
      required this.category,
      required this.shop,
      required this.price,
      required this.salePrice});

  Map<String, Object?> toDocument() {
    return {
      'quantity': quantity,
      'productId': productId,
      'picture': picture,
      'description': description,
      'category': category,
      'shop': shop,
      'price': price,
      'salePrice': salePrice,
      'name': name
    };
  }

  static ProductEntity fromDocument(Map<String, dynamic> doc) {
    return ProductEntity(
      quantity: doc['quantity'],
      productId: doc['productId'],
      picture: doc['picture'],
      description: doc['description'],
      category: doc['category'],
      shop: doc['shop'],
      price: doc['price'],
      salePrice: doc['salePrice'],
      name: doc['name'],
    );
  }
}

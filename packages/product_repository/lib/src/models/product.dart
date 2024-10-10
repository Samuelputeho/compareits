import '../entities/product_entity.dart';

class Product {
  double quantity;
  String productId;
  String name;
  String picture;
  String description;
  String category;
  String shop;
  double price;
  double salePrice;

  Product(
      {required this.quantity,
      required this.productId,
      required this.picture,
      required this.description,
      required this.category,
      required this.shop,
      required this.price,
      required this.salePrice,
      required this.name});

  ProductEntity toEntity() {
    return ProductEntity(
        quantity: quantity,
        productId: productId,
        name: name,
        picture: picture,
        description: description,
        category: category,
        shop: shop,
        price: price,
        salePrice: salePrice);
  }

  static Product fromEntity(ProductEntity entity) {
    return Product(
        quantity: entity.quantity,
        productId: entity.productId,
        name: entity.name,
        picture: entity.picture,
        description: entity.description,
        category: entity.category,
        shop: entity.shop,
        price: entity.price,
        salePrice: entity.salePrice);
  }
}

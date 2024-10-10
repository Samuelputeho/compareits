import 'package:product_repository/product_repository.dart';

import '../product_detail/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class Cart {
  static final Cart _instance = Cart._internal();

  factory Cart() {
    return _instance;
  }

  Cart._internal();

  List<CartItem> items = [];

  void addItem(Product product, int quantity) {
    final existingItem = items.firstWhere(
      (item) => item.product.name == product.name,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity == 0) {
      items.add(CartItem(product: product, quantity: quantity));
    } else {
      existingItem.quantity += quantity;
    }
  }

  void removeItem(Product product) {
    items.removeWhere((item) => item.product.name == product.name);
  }

  void updateQuantity(Product product, int quantity) {
    final item = items.firstWhere((item) => item.product.name == product.name);
    item.quantity = quantity;
  }

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  void printCartContents() {
    print("Cart contents:");
    for (var item in items) {
      print("${item.product.name}: ${item.quantity}");
    }
    print("Total items: $totalItems");
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../product_detail/product_model.dart';
import 'widgets/cart_tile.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // This would typically come from a state management solution
  List<Map<String, dynamic>> cartItems = [];

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      } else {
        cartItems.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconlyLight.arrowLeft2),
              iconSize: 20,
            ),
          ),
        ),
        title: const Text('Cart'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_horiz_outlined),
                iconSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: ListView.separated(
          itemCount: cartItems.length,
          separatorBuilder: (context, index) => SizedBox(height: 15),
          itemBuilder: (context, index) {
            final cartItem = cartItems[index];
            return CartTile(
              product: cartItem['product'],
              quantity: cartItem['quantity'],
              onRemove: () => removeItem(index),
              onIncrease: () => increaseQuantity(index),
              onDecrease: () => decreaseQuantity(index),
            );
          },
        ),
      ),
    );
  }
}

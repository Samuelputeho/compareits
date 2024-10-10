import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:product_repository/product_repository.dart';

import '../cart/cart_model.dart';
import '../home1/blocs/get_product_bloc/get_product_bloc.dart'; // Ensure you have this import for the Product model
// Import your product model from Firebase

class PickNPayProductDetailsPage extends StatefulWidget {
  final Product product;

  const PickNPayProductDetailsPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _PickNPayProductDetailsPageState createState() =>
      _PickNPayProductDetailsPageState();
}

class _PickNPayProductDetailsPageState
    extends State<PickNPayProductDetailsPage> {
  bool _isAdded = false;
  int _quantity = 1;
  final Cart _cart = Cart();

  void _addToCart() {
    setState(() {
      _isAdded = true;
      _cart.addItem(widget.product, _quantity);
    });
    _cart.printCartContents(); // Add this line
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                color: Colors.grey[300],
                child: Image.network(
                  // Changed to use network image for Firebase
                  widget.product.picture,
                  fit: BoxFit.contain,
                ),
              ),
              if (_isAdded)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: Text(
                        _quantity.toString(),
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "N\$${widget.product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        IconlyLight.bag,
                        color: Colors.grey,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      _isAdded
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.green,
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (_quantity > 1) {
                                          _quantity--;
                                        } else {
                                          _isAdded = false;
                                          _quantity = 1;
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.remove),
                                    color: Colors.white,
                                  ),
                                  Text(
                                    _quantity.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _quantity++;
                                      });
                                    },
                                    icon: Icon(Icons.add),
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: _addToCart,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 50),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.green,
                                ),
                                child: Text(
                                  "Add To Cart",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

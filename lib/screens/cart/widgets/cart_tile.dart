import 'package:flutter/material.dart';
import 'package:product_repository/product_repository.dart';

import '../../product_detail/product_model.dart';

class CartTile extends StatelessWidget {
  final Product product;
  final int quantity;
  final Function() onRemove;
  final Function() onIncrease;
  final Function() onDecrease;

  const CartTile({
    Key? key,
    required this.product,
    required this.quantity,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          //
          SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.name),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: onRemove,
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('N\$ ${product.price.toStringAsFixed(2)}'),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: onDecrease,
                              child: Container(
                                width: 22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Center(child: Text('-')),
                              ),
                            ),
                            SizedBox(width: 4),
                            Text('$quantity'),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: onIncrease,
                              child: Container(
                                width: 22,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '+',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
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

import 'package:firebase_auth_youtube/screens/home1/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';

class PickNpayProductTile extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final double price;

  const PickNpayProductTile({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetProductBloc(FirebaseProductRepo())..add(GetProduct()),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Adjusted height for the image container
            Container(
              height:
                  200, // Adjust the height here as needed (reduced from 200)
              width: double.infinity, // Full width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[100], // Background color of image container
              ),
              child: Image.network(
                imageUrl,
                // Adjust for image fit
              ),
            ),

            // Product Name with ellipsis
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                productName,
                textAlign: TextAlign.left, // Align text to the left
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1, // Limit to one line
                overflow:
                    TextOverflow.ellipsis, // Show ellipsis if text overflows
              ),
            ),

            // Product Price
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'N\$${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

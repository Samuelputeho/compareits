import 'package:firebase_auth_youtube/screens/home1/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';

import 'picknpay_product_page.dart';

class CategoryTile extends StatelessWidget {
  final String catName;
  final String imageUrl;
  final String storeName;

  const CategoryTile({
    Key? key,
    required this.catName,
    required this.imageUrl,
    required this.storeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => GetProductBloc(FirebaseProductRepo())
                ..add(GetProduct(
                    category: catName,
                    store: storeName)), // Pass the selected category and store
              child: PickNPayProductPage(categoryName: catName),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.3,
              width: MediaQuery.of(context).size.width * 0.3,
              child: Image.asset(imageUrl, fit: BoxFit.contain),
            ),
            const Spacer(),
            Center(child: Text(catName)),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

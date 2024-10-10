import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';
import '../home1/blocs/get_product_bloc/get_product_bloc.dart';
import 'picknpay_prod.dart';
// Ensure this import is correct

class PickNPayProductPage extends StatefulWidget {
  final String categoryName;

  const PickNPayProductPage({Key? key, required this.categoryName})
      : super(key: key);

  @override
  _PickNPayProductPageState createState() => _PickNPayProductPageState();
}

class _PickNPayProductPageState extends State<PickNPayProductPage> {
  @override
  void initState() {
    super.initState();
    // Fetch the products when the page initializes
    context.read<GetProductBloc>().add(GetProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // GridView of products
          Expanded(
            child: BlocBuilder<GetProductBloc, GetProductState>(
              builder: (context, state) {
                if (state is GetProductSuccess) {
                  // Filter products based on category only
                  final filteredProducts = state.products.where((product) {
                    return product.category ==
                        widget.categoryName; // Only filter by category
                  }).toList();

                  return BlocProvider(
                    create: (context) => GetProductBloc(FirebaseProductRepo())
                      ..add(GetProduct()),
                    child: const PickNPayProductList(),
                  ); // Update to not pass products directly
                } else if (state is GetProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetProductFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                return Container(); // Default case
              },
            ),
          ),
        ],
      ),
    );
  }
}

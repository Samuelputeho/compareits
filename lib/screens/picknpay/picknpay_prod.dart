import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';
import '../home1/blocs/get_product_bloc/get_product_bloc.dart';
import '../product_detail/product_model.dart'; // Ensure this matches your model structure
import 'picknpay_product_details_page.dart';
import 'picknpay_product_tile.dart';

class PickNPayProductList extends StatelessWidget {
  const PickNPayProductList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductBloc, GetProductState>(
      builder: (context, state) {
        if (state is GetProductSuccess) {
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.63,
              crossAxisSpacing: 0.8,
              mainAxisSpacing: 0,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, int i) {
              // Use products from state
              final Product product =
                  state.products[i]; // Ensure it's of type Product

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PickNPayProductDetailsPage(product: product),
                    ),
                  );
                },
                child: PickNpayProductTile(
                  imageUrl: product
                      .picture, // Make sure this field matches your model
                  productName: product.name,
                  price: product.price,
                ),
              );
            },
          );
        } else if (state is GetProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetProductFailure) {
          return Center(child: Text("An error occurred"));
        }

        // Default case to return an empty container
        return Container();
      },
    );
  }
}

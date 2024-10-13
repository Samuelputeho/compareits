import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';
import '../../picknpay/picknpay_product_details_page.dart';
import '../blocs/get_product_bloc/get_product_bloc.dart';
// Import your product details page

class SearchedPage extends StatelessWidget {
  final String searchQuery;

  const SearchedPage({Key? key, required this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dispatch the event to fetch products based on the search query
    context.read<GetProductBloc>().add(GetProduct(searchQuery: searchQuery));

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results for "$searchQuery"'),
      ),
      body: BlocBuilder<GetProductBloc, GetProductState>(
        builder: (context, state) {
          if (state is GetProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetProductFailure) {
            return Center(child: Text(state.message));
          } else if (state is GetProductSuccess) {
            return _buildProductList(
                context, state.products); // Pass context to the list builder
          }

          return Container(); // Default case
        },
      ),
    );
  }

  Widget _buildProductList(BuildContext context, List<Product> products) {
    if (products.isEmpty) {
      return Center(child: Text('No products found.'));
    }

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text(
              '${product.shop} \nPrice: N\$${product.price}'), // Display shop name and price
          leading: Image.network(product.picture), // Assuming picture is a URL
          onTap: () {
            // Navigate to the product details page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PickNPayProductDetailsPage(
                    product: product), // Pass the product
              ),
            );
          },
        );
      },
    );
  }
}

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
  // Define filter options for each category
  final Map<String, List<String>> categoryFilters = {
    'Grains and Pasta': ['All', 'Rice', 'Pasta', 'Macaroni'],
    'Dairy Products': ['All', 'Milk', 'Cheese', 'Yogurt'],
    // Add more categories and their filters as needed
  };

  @override
  void initState() {
    super.initState();
    // Fetch the products when the page initializes
    context
        .read<GetProductBloc>()
        .add(GetProduct(category: widget.categoryName));
  }

  void filterProducts(String filter) {
    // Dispatch an event to filter products based on the selected filter
    context.read<GetProductBloc>().add(GetProduct(
          category: widget.categoryName,
          store: 'PickNPay', // Pass the store name if needed
          searchQuery: filter == 'All'
              ? null
              : filter, // Pass the filter as a search query
        ));
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
          // Horizontal scrollable list of filter options
          Container(
            height: 60, // Set a height for the filter options
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryFilters[widget.categoryName]?.length ?? 0,
              itemBuilder: (context, index) {
                final filterOption =
                    categoryFilters[widget.categoryName]![index];
                return GestureDetector(
                  onTap: () {
                    filterProducts(filterOption); // Filter products on tap
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        filterOption,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<GetProductBloc, GetProductState>(
              builder: (context, state) {
                if (state is GetProductSuccess) {
                  return PickNPayProductList(); // Display the product list
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

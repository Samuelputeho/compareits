import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';

import '../blocs/get_product_bloc/get_product_bloc.dart';
import 'searched_page.dart';
// Import your product repository

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = [];
  List<Product> _products = []; // List to hold products fetched from Firebase
  List<String> _filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_updateSuggestions);
    _fetchProducts(); // Fetch products from Firebase
  }

  void _fetchProducts() async {
    // Fetch products from your repository or BLoC
    final productBloc = context.read<GetProductBloc>();
    productBloc.add(GetProduct()); // Trigger the event to fetch products

    // Listen for the state changes to get the products
    productBloc.stream.listen((state) {
      if (state is GetProductSuccess) {
        setState(() {
          _products = state.products; // Update the products list
          _filteredSuggestions = _products
              .map((product) => product.name)
              .toList(); // Initialize suggestions
        });
      } else if (state is GetProductFailure) {
        // Handle failure case
        print('Failed to fetch products: ${state.message}');
      }
    });
  }

  void _updateSuggestions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSuggestions = _products
          .where((product) => product.name.toLowerCase().contains(query))
          .map((product) => product.name) // Get the product names
          .toList();
    });
  }

  void _navigateToSearchedPage(String query) {
    // Check if the query is not empty and not already in recent searches
    if (query.isNotEmpty && !_recentSearches.contains(query)) {
      setState(() {
        _recentSearches.add(query); // Add the query to recent searches
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) =>
              GetProductBloc(FirebaseProductRepo()), // Provide the BLoC here
          child: SearchedPage(searchQuery: query), // Pass the search query
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Text(
          'C O M P A R E I T',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      _navigateToSearchedPage(_searchController.text);
                    }
                  },
                ),
                hintText: 'Search for your product',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: _searchController.text.isEmpty
                ? _buildRecentSearches()
                : _buildSuggestions(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearches() {
    return ListView.builder(
      itemCount: _recentSearches.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_recentSearches[index]),
          onTap: () {
            _navigateToSearchedPage(_recentSearches[index]);
          },
        );
      },
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      itemCount: _filteredSuggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_filteredSuggestions[index]),
          onTap: () {
            _navigateToSearchedPage(_filteredSuggestions[index]);
          },
        );
      },
    );
  }
}

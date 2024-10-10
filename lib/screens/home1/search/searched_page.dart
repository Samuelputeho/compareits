import 'package:flutter/material.dart';

class SearchedPage extends StatefulWidget {
  final String searchQuery;

  const SearchedPage({super.key, required this.searchQuery});

  @override
  State<SearchedPage> createState() => _SearchedPageState();
}

class _SearchedPageState extends State<SearchedPage> {
  late TextEditingController _searchController;
  final List<Map<String, dynamic>> _searchedProducts = [
    {
      "title": "Sunflower Cooking Oil",
      "price": "N\$6.99",
      "image": "assets/file.png"
    },
    {"title": "Olive Oil", "price": "N\$8.99", "image": "assets/file.png"},
    {"title": "Brown Bread", "price": "N\$2.99", "image": "assets/file.png"},
    {"title": "Cheap Oil", "price": "N\$3.99", "image": "assets/now.jpg"},
    {"title": "White Bread", "price": "N\$2.49", "image": "assets/now.jpg"},
    {"title": "Vita Juice", "price": "N\$4.49", "image": "assets/now.jpg"}
  ];

  List<Map<String, dynamic>> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery);
    _filteredProducts = _searchedProducts
        .where((product) => product['title']
            .toLowerCase()
            .contains(widget.searchQuery.toLowerCase()))
        .toList();
    _searchController.addListener(_updateProducts);
  }

  void _updateProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _searchedProducts
          .where((product) => product['title'].toLowerCase().contains(query))
          .toList();
    });
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
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for your product',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: _buildProductList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final item = _filteredProducts[index];
        return ListTile(
          leading: Image.asset(item['image'],
              width: 50, height: 50, fit: BoxFit.cover),
          title: Text(item['title']),
          subtitle: Row(
            children: [
              Text(item['price']),
              SizedBox(
                width: 20,
              ),
              Text("Shoprite"),
            ],
          ),
          onTap: () {
            // Handle product tap
            // For example, navigate to a product detail page
          },
        );
      },
    );
  }
}

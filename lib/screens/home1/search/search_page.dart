import 'package:flutter/material.dart';

import 'searched_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = ["Cooking Oil", "Bread", "Top Score"];
  final List<String> _suggestions = [
    "Sunflower Cooking Oil",
    "Olive Oil",
    "Brown Bread",
    "Cheap Oil",
    "White Bread",
    "Vita Juice"
  ];

  List<String> _filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_updateSuggestions);
    _filteredSuggestions = _suggestions; // Initial suggestions
  }

  void _updateSuggestions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSuggestions = _suggestions
          .where((suggestion) => suggestion.toLowerCase().contains(query))
          .toList();
    });
  }

  void _navigateToSearchedPage(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchedPage(searchQuery: query),
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
                    _navigateToSearchedPage(_searchController.text);
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

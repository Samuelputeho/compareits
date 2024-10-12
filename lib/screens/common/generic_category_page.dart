import 'package:flutter/material.dart';
import '../picknpay/picknpay_category_tile.dart';

class GenericCategoryPage extends StatelessWidget {
  final String storeName;

  GenericCategoryPage({Key? key, required this.storeName}) : super(key: key);

  // List of category names and their corresponding asset paths
  final List<Map<String, String>> categories = [
    {'name': 'Sweets and Biscuits', 'imageUrl': 'assets/snack.png'},
    {'name': 'Fruits and Vegetables', 'imageUrl': 'assets/lemon.png'},
    {'name': 'Dairy Products', 'imageUrl': 'assets/milk.png'},
    {'name': 'Bakery Items', 'imageUrl': 'assets/Bak.png'},
    {'name': 'Beverages', 'imageUrl': 'assets/Bev.png'},
    {'name': 'Wines', 'imageUrl': 'assets/wine.png'},
    {'name': 'Frozen Foods', 'imageUrl': 'assets/frozen.png'},
    {'name': 'Ready Meals', 'imageUrl': 'assets/ready.png'},
    {'name': 'Meat and Poultry', 'imageUrl': 'assets/meat.png'},
    {'name': 'Grains and Pasta', 'imageUrl': 'assets/mama2.png'},
    {'name': 'Condiments', 'imageUrl': 'assets/spices.png'},
    {'name': 'Health and Wellness', 'imageUrl': 'assets/health3.png'},
    {'name': 'Personal Care', 'imageUrl': 'assets/Personal.png'},
    {'name': 'Household Supplies', 'imageUrl': 'assets/house.png'},
    {'name': 'Pet Food', 'imageUrl': 'assets/pet3.png'},
    {'name': 'Cleaning Products', 'imageUrl': 'assets/omo.png'},
    {'name': 'Baby Products', 'imageUrl': 'assets/baby1.png'},
    {'name': 'Office Supplies', 'imageUrl': 'assets/office.png'},
    {'name': 'Electronics', 'imageUrl': 'assets/home3.png'},
    {'name': 'Clothing', 'imageUrl': 'assets/clothing.png'},
    {'name': 'Books and Magazines', 'imageUrl': 'assets/newss.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              iconSize: 20,
            ),
          ),
        ),
        title: Text(storeName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_horiz_outlined),
                iconSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 180 / 260,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return CategoryTile(
              catName: categories[index]['name']!,
              imageUrl: categories[index]['imageUrl']!,
              storeName: storeName, // Pass the store name here
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';

import '../../checkers/checkers_category_page.dart';
import '../../foodlovers/foodlovers_category_page.dart';
import '../../picknpay/picknpay_category_page.dart';
import '../../shoprite/shoprite_category_page.dart';
import 'widgets/nov_tile.dart';
import 'widgets/shop_tile.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < 2) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {}); // Trigger a rebuild to update the dots indicator
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double imageHeight = 150.0;
    final double dotSize = 12.0;
    final double dotSpacing = 8.0;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sales container
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: imageHeight,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 219, 217, 217),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      children: [
                        Image.asset(
                          'assets/card.jpg',
                          fit: BoxFit.fill,
                        ),
                        Image.asset(
                          'assets/card1.jpg',
                          fit: BoxFit.fill,
                        ),
                        Image.asset(
                          'assets/card2.jpg',
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: dotSpacing / 2),
                        width: _currentIndex == index ? dotSize : dotSize - 4,
                        height: _currentIndex == index ? dotSize : dotSize - 4,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? Colors.white
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Novelties of the week',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "See all",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.width * 0.7,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      NovTile(
                        foodImage: 'assets/mama2.png',
                        foodName: 'Mamas Rice',
                        foodPrice: 'N\$60.99',
                        foodQuantity: '2Kg',
                        foodRating: '5.0',
                        foodShop: 'Shoprite',
                      ),
                      SizedBox(width: 10),
                      NovTile(
                        foodImage: 'assets/topscore.png',
                        foodName: 'Topscore 1 kg',
                        foodPrice: 'N\$130.99',
                        foodQuantity: '500g',
                        foodRating: '5.0',
                        foodShop: 'PickNPay',
                      ),
                      SizedBox(width: 10),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Grocery Stores',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.width *
                    0.93, // Adjust the max height based on your needs
              ),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: false,
                physics:
                    const NeverScrollableScrollPhysics(), // Prevent GridView from scrolling
                children: [
                  ShopTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PicknpayCategoryPage(),
                        ),
                      );
                    },
                    shopName: 'PickNPay',
                    shopLogo: 'assets/picklogob.png',
                  ),
                  ShopTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShopriteCategoryPage(),
                        ),
                      );
                    },
                    shopName: 'Shoprite',
                    shopLogo: 'assets/shopritelogo2.png',
                  ),
                  ShopTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckersCategoryPage(),
                        ),
                      );
                    },
                    shopName: 'Checkers',
                    shopLogo: 'assets/checkerslogo.png',
                  ),
                  ShopTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodLoversCategoryPage(),
                        ),
                      );
                    },
                    shopName: 'FoodLovers',
                    shopLogo: 'assets/foodloverslogo1.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

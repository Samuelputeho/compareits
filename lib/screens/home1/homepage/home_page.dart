import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../widgets/appconst.dart';
import '../../../widgets/text_widget.dart';
import '../sales/sales_page.dart';
import '../search/search_page.dart';
import 'shop_page.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < 2) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              const Icon(IconlyBold.location),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: "Delivery:",
                    textSize: AppConstants.mainFont9,
                    color: Colors.green,
                  ),
                  TextWidget(
                    text: "Khomasdal, plaatjies street",
                    textSize: 15,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(IconlyLight.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(IconlyLight.notification),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // tabbar
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 219, 217, 217),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                  indicatorPadding: const EdgeInsets.all(3),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tabs: const [
                    Tab(
                      text: 'Shop',
                    ),
                    Tab(
                      text: 'Sales',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Expanded(
                child: TabBarView(
                  children: [
                    ShopPage(),
                    SalesPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

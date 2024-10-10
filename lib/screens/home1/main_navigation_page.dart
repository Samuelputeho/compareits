import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../cart/cart_page.dart';
import '../likes/likes_page.dart';
import '../profile/profile_screen.dart';
import '../wallet/wallet_page.dart';
import 'homepage/home_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage1(),
    WalletPage(),
    CartPage(),
    LikesPage(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  IconData _getIconData(int index, bool isSelected) {
    switch (index) {
      case 0:
        return isSelected ? IconlyBold.home : IconlyLight.home;
      case 1:
        return isSelected ? IconlyBold.wallet : IconlyLight.wallet;
      case 2:
        return isSelected ? IconlyBold.bag : IconlyLight.bag;
      case 3:
        return isSelected ? IconlyBold.heart : IconlyLight.heart;
      case 4:
        return isSelected ? IconlyBold.profile : IconlyLight.profile;
      default:
        return IconlyLight.home; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Light mode background color
        elevation: 0,
        items: List.generate(5, (index) {
          return BottomNavigationBarItem(
            icon: Icon(
              _getIconData(index, index == _selectedIndex),
              size: 25, // Adjust the icon size as needed
              color: index == _selectedIndex ? Colors.green : Colors.grey,
            ),
            label: '',
          );
        }),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

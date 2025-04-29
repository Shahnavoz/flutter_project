import 'package:flutter/material.dart';
import 'package:internet_shop/pages/main_pages/cart_page.dart';
import 'package:internet_shop/pages/main_pages/category_page.dart';
import 'package:internet_shop/pages/main_pages/me_page.dart';
import 'package:internet_shop/pages/main_pages/shop_page.dart';

class Navigationpage extends StatefulWidget {
  const Navigationpage({super.key});

  @override
  State<Navigationpage> createState() => _NavigationpageState();
}

class _NavigationpageState extends State<Navigationpage> {
  int _selectedIndex=0;

  List<Widget> pages=[
    ShopPage(),
    CategoryPage(),
    CartPage(),
    MePage()
  ];

  void selectIndex(int index)
  {
    setState(() {
      _selectedIndex = index;
    });
  }


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: selectIndex,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: 
      [
        BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined),label: 'Shop'),
        BottomNavigationBarItem(icon: Icon(Icons.category_outlined),label: 'Category'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined),label: 'Me'),
      ]
      ),
    );
  }
}
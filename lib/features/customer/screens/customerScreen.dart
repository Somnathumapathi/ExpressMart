import 'package:expressmart/features/cart/screens/cartScreen.dart';
import 'package:expressmart/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../../account/screens/accountScreen.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});
  static const routeName = "/customer-home";
  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  List<Widget> screens = [HomeScreen(), AccountScreen(), CartScreen()];
  int _screenIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_screenIdx],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(),
                child: badges.Badge(
                  badgeContent: Text('0'),
                  child: Icon(Icons.shopping_cart),
                ),
              ),
              label: ''),
        ],
        currentIndex: _screenIdx,
        onTap: (value) {
          setState(() {
            _screenIdx = value;
          });
        },
      ),
    );
  }
}

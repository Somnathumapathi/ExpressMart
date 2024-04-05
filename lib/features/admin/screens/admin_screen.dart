import 'package:expressmart/features/admin/screens/analyticsscreen.dart';
import 'package:expressmart/features/admin/screens/ordersscreen.dart';
import 'package:expressmart/features/admin/screens/productsscreen.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _screenIdx = 0;
  final List<Widget> _screens = [
    ProductsScreen(),
    AnalyticsScreen(),
    OrdersScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Express Mart'),
          Text(
            'Admin',
            style: TextStyle(fontSize: 12),
          )
        ]),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
      ),
      body: _screens[_screenIdx],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.outbox_rounded), label: ''),
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
// PreferredSize(
//           preferredSize: const Size.fromHeight(60),
//           child: AppBar(
//             flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                 gradient: GlobalVariables.appBarGradient,
//               ),
//             ),
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Container(
//                       height: 40,
//                       child: Material(
//                         elevation: 1,
//                         borderRadius: BorderRadius.circular(7),
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             hintText: 'Search products',
//                             fillColor: const Color.fromARGB(60, 14, 0, 0),
//                             filled: true,
//                             suffixIcon: InkWell(
//                               child: Icon(Icons.search),
//                               onTap: () {},
//                             ),
//                           ),
//                         ),
//                       )),
//                 ),
//               ],
//             ),
//           ),
//         ),
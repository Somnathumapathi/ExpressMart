import 'package:expressmart/features/home/widgets/addressbox.dart';
import 'package:expressmart/features/home/widgets/categoryOptions.dart';
import 'package:expressmart/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'home-screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      height: 40,
                      child: Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(7),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Search products',
                            fillColor: const Color.fromARGB(60, 14, 0, 0),
                            filled: true,
                            suffixIcon: InkWell(
                              child: Icon(Icons.search),
                              onTap: () {},
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        body:
            // Center(child: Text(user.toJson())),
            Column(
          children: [AddressBox(), CategoryOptions()],
        ));
  }
}

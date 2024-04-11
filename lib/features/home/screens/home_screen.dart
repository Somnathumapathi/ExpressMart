import 'package:expressmart/features/home/screens/search_screen.dart';
import 'package:expressmart/features/home/widgets/addressbox.dart';
import 'package:expressmart/features/home/widgets/carouselslider.dart';
import 'package:expressmart/features/home/widgets/categoryOptions.dart';
import 'package:expressmart/features/home/widgets/todaysdeal.dart';
import 'package:expressmart/provider/user_provider.dart';
import 'package:expressmart/services/home_services.dart';
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
  final _searchController = TextEditingController();
  final homeservices = HomeServices();
  List<String> searchSuggestions = [];
  _fetchSearchSuggestions(String ch) async {
    searchSuggestions = await homeservices.fetchSearchSuggestions(context, ch);
    setState(() {});
  }

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
                          onChanged: (value) {
                            _fetchSearchSuggestions(value);
                          },
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search products',
                            fillColor: const Color.fromARGB(60, 14, 0, 0),
                            filled: true,
                            suffixIcon: InkWell(
                              child: Icon(Icons.search),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, SearchScreen.routeName,
                                    arguments: _searchController.text);
                              },
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: searchSuggestions.isNotEmpty &&
                  _searchController.text.isNotEmpty
              ? Container(
                  height: 250,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchSuggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(searchSuggestions[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_outward),
                            onPressed: () {
                              _searchController.text = searchSuggestions[index];
                              _fetchSearchSuggestions(_searchController.text);
                            },
                          ),
                        );
                      }),
                )
              : Column(
                  children: [
                    AddressBox(),
                    SizedBox(
                      height: 10,
                    ),
                    CategoryOptions(),
                    CarouselWidget(),
                    TodaysDeal()
                  ],
                ),
        ));
  }
}

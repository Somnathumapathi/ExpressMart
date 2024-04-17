import 'package:expressmart/common/widgets/customButton.dart';
import 'package:expressmart/features/home/widgets/addressbox.dart';
import 'package:expressmart/features/cart/widgets/cartProduct_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../provider/user_provider.dart';
import '../../../services/home_services.dart';
import '../../home/screens/search_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _searchController = TextEditingController();
  final homeservices = HomeServices();
  List<String> searchSuggestions = [];
  _fetchSearchSuggestions(String ch) async {
    searchSuggestions = await homeservices.fetchSearchSuggestions(context, ch);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    double subTotal = 0;

    userProvider.user.cart
        .map((e) => subTotal +=
            (e['quantity'] * e['product']['price'] as int).toDouble())
        .toList();

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
                            title: InkWell(
                              child: Text(searchSuggestions[index]),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, SearchScreen.routeName,
                                    arguments: searchSuggestions[index]);
                              },
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.arrow_outward),
                              onPressed: () {
                                _searchController.text =
                                    searchSuggestions[index];
                                _fetchSearchSuggestions(_searchController.text);
                              },
                            ),
                          );
                        }),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddressBox(),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: RichText(
                            text: TextSpan(
                                text: 'SubTotal: \$',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                                children: [
                              TextSpan(
                                  text: subTotal.toString(),
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                      color: GlobalVariables.secondaryColor))
                            ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          text: 'Place order',
                          onTap: () {},
                          color: GlobalVariables.secondaryColor,
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: userProvider.user.cart.length,
                          itemBuilder: (context, index) {
                            return CartProduct(index: index);
                          }),
                    ],
                  )
//       body:
            ));
  }
}

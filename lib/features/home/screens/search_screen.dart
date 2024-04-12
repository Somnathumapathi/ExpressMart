import 'package:expressmart/common/widgets/loader.dart';
import 'package:expressmart/common/widgets/ratings.dart';
import 'package:expressmart/features/home/screens/home_screen.dart';
import 'package:expressmart/features/product-details/screens/productDetails_screen.dart';
import 'package:expressmart/services/home_services.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../../account/widgets/productwidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.searchQuery});
  final String searchQuery;
  static const String routeName = '/search-screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final homeServices = HomeServices();
  List<Product>? products;
  fetchSearchProducts() async {
    products =
        await homeServices.fetchSearchResults(context, widget.searchQuery);
    setState(() {});
  }

  @override
  void initState() {
    fetchSearchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Loader()
        : Scaffold(
            appBar: AppBar(
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Express Mart'),
                    Text(
                      widget.searchQuery,
                      style: TextStyle(fontSize: 12),
                    )
                  ]),
              flexibleSpace: Container(
                decoration:
                    BoxDecoration(gradient: GlobalVariables.appBarGradient),
              ),
            ),
            body: GridView.builder(
                itemCount: products!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (1 / 1.3),
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  // return Container(
                  //   child: Column(children: [
                  //     SizedBox(
                  //       height: 150,
                  //       child: Image.network(
                  //         productData.imageUrls[0],
                  //         fit: BoxFit.cover,
                  //       ),
                  //     )
                  //   ]),
                  // );
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, ProductDetailsScreen.routeName,
                          arguments: productData);
                    },
                    child: Container(
                      // padding: EdgeInsets.only(top: 8),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      // color: Colors.black26,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.white)),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 132,
                            child: ProductWidget(
                                imgUrl: productData.imageUrls[0],
                                prName: productData.productName),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      productData.productName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RatingsWidget(ratings: 5)
                                  ],
                                ),
                                Text(
                                  productData.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white60),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: GlobalVariables.secondaryColor,
                                      ),
                                      child: Text(
                                        productData.category,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Text(
                                      '\$ ' + productData.price.toString(),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
  }
}

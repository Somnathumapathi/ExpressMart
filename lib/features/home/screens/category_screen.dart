import 'package:expressmart/common/widgets/loader.dart';
import 'package:expressmart/services/home_services.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/ratings.dart';
import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../../account/widgets/productwidget.dart';
import '../../product-details/screens/productDetails_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.category});
  final String category;
  static const routeName = 'category-screen';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final homeServices = HomeServices();
  List<Product>? products;
  fetchCatProducts() async {
    products =
        await homeServices.fetchCategoryProducts(context, widget.category);
    print(products!.length);
    setState(() {});
  }

  @override
  void initState() {
    fetchCatProducts();
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
                      widget.category,
                      style: TextStyle(fontSize: 12),
                    )
                  ]),
              flexibleSpace: Container(
                decoration:
                    BoxDecoration(gradient: GlobalVariables.appBarGradient),
              ),
            ),
            body:
                // body: GridView.builder(
                //     itemCount: 1,
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: 2),
                //     itemBuilder: (context, index) {
                //       final productData = products![index];
                //       return Container(
                //         padding: EdgeInsets.all(8),
                //         // color: Colors.black26,
                //         child: Column(
                //           children: [
                //             SizedBox(
                //               height: 132,
                //               child: ProductWidget(
                //                   imgUrl: productData.imageUrls[0],
                //                   prName: productData.productName),
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //               children: [
                //                 Text(
                //                   productData.productName,
                //                 ),
                //                 Text(
                //                   '\$ ' + productData.price.toString(),
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       );
                //     }),
                GridView.builder(
                    itemCount: products!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (1 / 1.3),
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      final productData = products![index];
                      double totalRating = 0;
                      for (int i = 0; i < productData.ratings!.length; i++) {
                        totalRating += productData.ratings![i].rating;
                      }
                      double avgRating = 0;
                      if (totalRating != 0) {
                        avgRating = totalRating / productData.ratings!.length;
                      }
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
                                        RatingsWidget(ratings: avgRating)
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
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color:
                                                GlobalVariables.secondaryColor,
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

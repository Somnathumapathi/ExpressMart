import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:expressmart/common/widgets/customButton.dart';
import 'package:expressmart/common/widgets/ratings.dart';
import 'package:expressmart/features/home/widgets/carouselslider.dart';
import 'package:expressmart/services/product_details_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../../../provider/user_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Product product;
  static const String routeName = '/product-details-screen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final productDetailsServices = ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;
  int imageIndex = 0;
  final _scrollcontroller = ScrollController();
  void fetchRating() {
    double totalRating = 0;
    for (int i = 0; i < widget.product.ratings!.length; i++) {
      totalRating = widget.product.ratings![i].rating;
      if (widget.product.ratings![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.ratings![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.ratings!.length;
    }
  }

  @override
  void initState() {
    fetchRating();
    super.initState();
  }

  @override
  void dispose() {
    _scrollcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageBottom = MediaQuery.of(context).size.height - 10;
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Express Mart'),
          Text(
            widget.product.productName,
            style: TextStyle(fontSize: 12),
          )
        ]),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollcontroller,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: () {}, child: Text('Seller : nmos')),
                  GestureDetector(
                      child: RatingsWidget(ratings: avgRating),
                      onTap: () {
                        _scrollcontroller.animateTo(pageBottom,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn);
                      })
                ],
              ),
              Text(
                widget.product.productName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              CarouselSlider(
                items: widget.product.imageUrls.map((e) {
                  return Builder(
                      builder: (BuildContext context) => Image.network(
                            e,
                            fit: BoxFit.cover,
                            height: 200,
                          ));
                }).toList(),
                options: CarouselOptions(
                    viewportFraction: 1,
                    onPageChanged: (index, r) {
                      setState(() {
                        imageIndex = index;
                      });
                    }),
              ),
              Center(
                child: DotsIndicator(
                  dotsCount: widget.product.imageUrls.length,
                  position: imageIndex,
                  decorator: DotsDecorator(
                      color: Colors.white54,
                      activeColor: GlobalVariables.secondaryColor),
                ),
              ),
              RichText(
                  text: TextSpan(
                      text: 'Deal Price: \$ ',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                    TextSpan(
                      text: widget.product.price.toString(),
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ])),
              RichText(
                  text: TextSpan(
                      text: 'MRP: \$ ',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                    TextSpan(
                      text: widget.product.price.toString(),
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough),
                    )
                  ])),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.add_location_outlined,
                  ),
                  Text(
                    "Deliver to address: " + userProvider.user.address,
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // CustomButton(text: 'Add to cart', onTap: () {}),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Add to cart'),
                    style: ElevatedButton.styleFrom(),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Buy now'))
                ],
              ),
              Container(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 57, 56, 56)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About product:',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.product.description)
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Rate the product:',
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              RatingBar.builder(
                  itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                  initialRating: myRating,
                  itemCount: 5,
                  minRating: 1,
                  allowHalfRating: true,
                  onRatingUpdate: (rating) {
                    productDetailsServices.rateProduct(
                        context: context,
                        product: widget.product,
                        rating: rating);
                    setState(() {});
                  })
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:expressmart/common/widgets/loader.dart';
import 'package:expressmart/services/home_services.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../../account/widgets/productwidget.dart';

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
            body: GridView.builder(
                itemCount: 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return Container(
                    padding: EdgeInsets.all(8),
                    // color: Colors.black26,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 132,
                          child: ProductWidget(
                              imgUrl: productData.imageUrls[0],
                              prName: productData.productName),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              productData.productName,
                            ),
                            Text(
                              '\$ ' + productData.price.toString(),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          );
  }
}

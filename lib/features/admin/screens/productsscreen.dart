import 'package:expressmart/common/widgets/loader.dart';
import 'package:expressmart/features/account/widgets/productwidget.dart';
import 'package:expressmart/features/admin/screens/add_products_screen.dart';
import 'package:expressmart/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product>? products;
  final adminServices = AdminServices();

  fetchProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  Future<void> _handleRefresh() async {
    await fetchProducts();
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  void delProduct(Product product, int index) {
    adminServices.deleteProduct(context, product, () {
      products!.removeAt(index);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Loader()
        : Scaffold(
            body: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  itemCount: products!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final productData = products![index];
                    return Container(
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
                              IconButton(
                                  onPressed: () {
                                    delProduct(productData, index);
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  shrinkWrap: true,
                )
              ]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductsScreen.routeName);
              },
              child: Icon(Icons.add),
            ),
          );
  }
}

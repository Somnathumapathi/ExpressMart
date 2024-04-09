import 'package:expressmart/common/widgets/loader.dart';
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

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products == null ? Loader() : Text(products![0].productName),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddProductsScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

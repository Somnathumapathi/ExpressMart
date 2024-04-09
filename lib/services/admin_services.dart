import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:expressmart/constants/error_handler.dart';
import 'package:expressmart/models/product.dart';
import 'package:expressmart/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:expressmart/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/global_variables.dart';
import '../secrets.dart';

class AdminServices {
  void sellProduct(
      {required BuildContext context,
      required String productName,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final cloudinary = CloudinaryPublic(cloudName, uploadPresets);
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(images[i].path, folder: productName));
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
          productName: productName,
          description: description,
          price: price,
          quantity: quantity,
          imageUrls: imageUrls,
          category: category);

      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: product.toJson());
      httpErrorHandler(
          res: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Successfully added product');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );

      httpErrorHandler(
          res: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              // print(Product.fromJson(jsonEncode(jsonDecode(res.body)[0])));
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
      // print('Hi');
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}

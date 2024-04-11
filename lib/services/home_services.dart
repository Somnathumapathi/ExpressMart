import 'dart:convert';

import 'package:expressmart/constants/error_handler.dart';
import 'package:expressmart/constants/global_variables.dart';
import 'package:expressmart/constants/utils.dart';
import 'package:expressmart/models/product.dart';
import 'package:expressmart/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts(
      BuildContext context, String category) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });
      httpErrorHandler(
          res: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<List<String>> fetchSearchSuggestions(
      BuildContext context, String ch) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<String> productNames = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/search-suggestions?ch=$ch'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });
      httpErrorHandler(
          res: res,
          context: context,
          onSuccess: () {
            List<dynamic> resData = jsonDecode(res.body);

            for (int i = 0; i < resData.length; i++) {
              String productName = resData[i]['productName'];
              productNames.add(productName);
              // print(productNames);
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productNames;
  }

  Future<List<Product>> fetchSearchResults(
      BuildContext context, String query) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/search/$query'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });
      httpErrorHandler(
          res: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}

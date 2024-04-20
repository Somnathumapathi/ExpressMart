import 'dart:convert';

import 'package:expressmart/constants/error_handler.dart';
import 'package:expressmart/constants/global_variables.dart';
import 'package:expressmart/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/user.dart';
import '../provider/user_provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      print(product.id);
      http.Response res = await http.post(Uri.parse('$uri/api/rate-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({'id': product.id, 'rating': rating}));
      httpErrorHandler(res: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

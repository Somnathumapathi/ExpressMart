import 'dart:convert';

import 'package:expressmart/constants/error_handler.dart';
import 'package:expressmart/constants/global_variables.dart';
import 'package:expressmart/constants/utils.dart';
import 'package:expressmart/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/user.dart';

class CartServices {
  void addToCart(BuildContext context, String id) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/add-to-cart'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({'id': id}));
      httpErrorHandler(
          res: res,
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setModelUser(user);
            showSnackBar(context, 'Added to cart successfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void removeFromCart(BuildContext context, String id) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http
          .delete(Uri.parse('$uri/api/remove-from-cart/${id}'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });
      httpErrorHandler(
          res: res,
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setModelUser(user);
            showSnackBar(context, 'Removed item from cart');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

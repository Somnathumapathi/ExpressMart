import 'dart:convert';

import 'package:expressmart/constants/error_handler.dart';
import 'package:expressmart/constants/global_variables.dart';
import 'package:expressmart/constants/utils.dart';
import 'package:expressmart/features/customer/screens/customerScreen.dart';
import 'package:expressmart/features/home/screens/home_screen.dart';
import 'package:expressmart/models/user.dart';
import 'package:expressmart/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '');
      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandler(
          res: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'User created now login');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void loginUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/login'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      //
      // print(res.body);
      // ignore: use_build_context_synchronously
      httpErrorHandler(
          res: res,
          context: context,
          onSuccess: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await pref.setString('x-auth-token', jsonDecode(res.body)['token']);
            // ignore: use_build_context_synchronously
            Navigator.pushNamedAndRemoveUntil(
                context, CustomerScreen.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      // print('Reeached');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      print(token);
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      // print('Reeached token is $token');
      http.Response tokenRes = await http.post(Uri.parse('$uri/isValidToken'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });
      // print('Reeached1');
      var response = jsonDecode(tokenRes.body);
      print(response.toString());
      if (response == true) {
        http.Response res = await http.get(Uri.parse('$uri/get-user'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        // print('Reeached');
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(res.body);
        // print(userProvider.user.token);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

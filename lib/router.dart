import 'package:expressmart/features/admin/screens/add_products_screen.dart';
import 'package:expressmart/features/auth/screens/auth_screen.dart';
import 'package:expressmart/features/customer/screens/customerScreen.dart';
import 'package:expressmart/features/home/screens/category_screen.dart';
import 'package:expressmart/features/home/screens/home_screen.dart';
import 'package:expressmart/features/home/screens/search_screen.dart';
import 'package:expressmart/features/product-details/screens/productDetails_screen.dart';
import 'package:expressmart/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());

    case CustomerScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CustomerScreen());

    case AddProductsScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductsScreen());

    case CategoryScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryScreen(category: category));

    case SearchScreen.routeName:
      var query = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(searchQuery: query));

    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: product));

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Are you lost baby girl? 😏'),
                ),
              ));
  }
}

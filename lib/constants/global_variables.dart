import 'package:flutter/material.dart';

String uri = 'https://express-mart-backend.vercel.app';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 5, 36, 76), // Dark Blue
      Color.fromARGB(255, 3, 169, 244), // Deep Sky Blue
    ],
    stops: [0.5, 1.0],
  );

  static const primaryColor = Color.fromRGBO(0, 150, 136, 1); // Dark Teal
  static const secondaryColor = Color.fromRGBO(255, 152, 0, 1); // Orange
  static const backgroundColor = Color(0xff121212); // Dark Grey
  static const Color greyBackgroundColor =
      Color(0xff1f1f1f); // Slightly Lighter Dark Grey
  static var selectedNavBarColor = Colors.blue[800]!; // Blue
  static const unselectedNavBarColor = Colors.grey; // Grey

  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];
  static const List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];
  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.jpeg',
    },
  ];
}

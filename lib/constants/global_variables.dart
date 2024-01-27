import 'package:flutter/material.dart';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 0, 15, 34), // Dark Blue
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
}

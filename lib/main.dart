import 'package:expressmart/constants/global_variables.dart';
import 'package:expressmart/features/auth/screens/auth_screen.dart';
import 'package:expressmart/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme:
                const ColorScheme.dark(primary: GlobalVariables.secondaryColor),
            appBarTheme: const AppBarTheme()),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const AuthScreen());
  }
}

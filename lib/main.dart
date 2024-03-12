import 'package:expressmart/constants/global_variables.dart';
import 'package:expressmart/features/auth/screens/auth_screen.dart';
import 'package:expressmart/features/customer/screens/customerScreen.dart';
import 'package:expressmart/features/home/screens/home_screen.dart';
import 'package:expressmart/provider/user_provider.dart';
import 'package:expressmart/router.dart';
import 'package:expressmart/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    authService.getUserData(context);
    super.initState();
  }

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
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? const CustomerScreen()
            : const AuthScreen());
  }
}

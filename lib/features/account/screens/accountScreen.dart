import 'package:expressmart/constants/global_variables.dart';
import 'package:expressmart/features/account/widgets/orders.dart';
import 'package:flutter/material.dart';

import '../widgets/accountOptions.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExpressMart'),
        // backgroundColor: GlobalVariables.appBarGradient,
      ),
      body: Column(
        children: [
          AccountOptions(),
          SizedBox(
            height: 20,
          ),
          Orders()
        ],
      ),
    );
  }
}

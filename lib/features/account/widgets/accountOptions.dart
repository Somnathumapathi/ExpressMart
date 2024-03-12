import 'package:expressmart/features/account/widgets/optionButton.dart';
import 'package:flutter/material.dart';

class AccountOptions extends StatelessWidget {
  const AccountOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OptionButton(
              text: 'Your Orders',
              onPressed: () {},
            ),
            OptionButton(
              text: 'Seller',
              onPressed: () {},
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OptionButton(
              text: 'Logout',
              onPressed: () {},
            ),
            OptionButton(
              text: 'Wish List',
              onPressed: () {},
            )
          ],
        ),
      ],
    ));
  }
}

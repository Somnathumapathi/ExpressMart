import 'package:expressmart/features/account/widgets/productwidget.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final list = [
    {
      'name': 'Product 1',
      'image':
          'https://images-cdn.ubuy.co.in/6490875a755e6d10b310f8bf-iron-bull-strength-powerlifting-lever.jpg'
    },
    {
      'name': 'Product 2',
      'image':
          'https://images-cdn.ubuy.co.in/6490875a755e6d10b310f8bf-iron-bull-strength-powerlifting-lever.jpg'
    },
    {
      'name': 'Product 3',
      'image':
          'https://images-cdn.ubuy.co.in/6490875a755e6d10b310f8bf-iron-bull-strength-powerlifting-lever.jpg'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Your Orders", style: TextStyle(fontSize: 22)),
            TextButton(onPressed: () {}, child: const Text('See all >>'))
          ],
        ),
        SizedBox(
          height: 20,
        ),
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 0,
          ),
          itemCount: list.length,
          itemBuilder: ((context, index) {
            String primg = list[index]['image']!;
            String prName = list[index]['name']!;
            return Column(
              children: [
                ProductWidget(imgUrl: primg, prName: prName),
                Text(prName)
              ],
            );
          }),
          shrinkWrap: true,
        )
      ],
    );
  }
}

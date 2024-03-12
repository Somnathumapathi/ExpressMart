import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.imgUrl, required this.prName});
  final String imgUrl;
  final String prName;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      height: 170,
      child: Column(children: [Image.network(imgUrl), Text(prName)]),
    );
  }
}

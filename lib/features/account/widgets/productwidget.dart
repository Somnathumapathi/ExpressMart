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
      // padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Container(
          width: 180,
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              ),
          // padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
              width: 180,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingsWidget extends StatelessWidget {
  const RatingsWidget({super.key, required this.ratings});
  final double ratings;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemSize: 15,
      itemCount: 5,
      direction: Axis.horizontal,
      rating: ratings,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.yellow,
      ),
    );
  }
}

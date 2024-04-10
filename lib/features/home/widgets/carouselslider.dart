import 'package:carousel_slider/carousel_slider.dart';
import 'package:expressmart/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: GlobalVariables.carouselImages.map((e) {
          return Builder(
              builder: (BuildContext context) => Image.network(
                    e,
                    fit: BoxFit.cover,
                    height: 200,
                  ));
        }).toList(),
        options: CarouselOptions(
            viewportFraction: 1,
            height: 200,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5)));
  }
}

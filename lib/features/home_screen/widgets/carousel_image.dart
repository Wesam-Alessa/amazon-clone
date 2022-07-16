import 'package:amazon_clone/constants/dimensions.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          viewportFraction: 1,
          height: Dimensions.height20 * 10,
          autoPlay: true),
      items: GlobalVariables.carouselImages.map((e) {
        return Builder(
          builder: (
            BuildContext context,
          ) =>
              Image.network(
            e,
            fit: BoxFit.cover,
            height: Dimensions.height20 * 10,
          ),
        );
      }).toList(),
    );
  }
}

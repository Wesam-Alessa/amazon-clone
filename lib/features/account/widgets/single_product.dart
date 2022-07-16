import 'package:amazon_clone/constants/dimensions.dart';
import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  const SingleProduct({Key? key,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.screenWidth*0.9,
      height:Dimensions.screenHeight * 0.25,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 / 2),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(Dimensions.radius10 / 2),
            color: Colors.white),
        child: Container(
          padding: EdgeInsets.all(Dimensions.width10/2),
          child: Image.network(
          image,
          fit: BoxFit.fill,
          width: Dimensions.screenWidth * 0.5,
         
          ),
        ),
      ),
    );
  }
}

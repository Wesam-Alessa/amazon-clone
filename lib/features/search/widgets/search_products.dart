import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/constants/dimensions.dart';
 import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  final ProductModel productModel;
  const SearchedProduct({Key? key, required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
     double totalRating = 0;
    for (int i = 0; i < productModel.rating!.length; i++) {
      totalRating += productModel.rating![i].rating;
    }
    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / productModel.rating!.length;
    }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
          child: Row(
            children: [
              Image.network(
                productModel.images[0],
                fit: BoxFit.fitWidth,
                height: Dimensions.height30 * 4,
                width: Dimensions.height30 * 4,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10,
                        top: Dimensions.height10 / 2),
                    child: Text(
                      productModel.name,
                      style: TextStyle(fontSize: Dimensions.font16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width10,
                          top: Dimensions.height10 / 2),
                      child:  Stars(rating: avgRating)),
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10,
                        top: Dimensions.height10 / 2),
                    child: Text(
                      "\$${productModel.price}",
                      style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: Dimensions.width10),
                    child: const Text(
                      "Eligible for FREE Shipping",
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10,
                        top: Dimensions.height10 / 2),
                    child: const Text(
                      "In Stock",
                      style: TextStyle(color: Colors.teal),
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

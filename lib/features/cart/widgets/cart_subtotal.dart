import 'package:amazon_clone/constants/dimensions.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().userModel;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Container(
      margin: EdgeInsets.all(Dimensions.width10/2),
      child: Row(
        children: [
          Text(
            "subtotal ",
            style: TextStyle(fontSize: Dimensions.font20),
          ),
           Text(
            "\$$sum ",
            style: TextStyle(fontSize: Dimensions.font20,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

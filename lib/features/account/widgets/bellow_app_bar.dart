import 'package:amazon_clone/constants/dimensions.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class BellowAppBar extends StatelessWidget {
  const BellowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true).userModel;
    return Container(
      width: Dimensions.screenWidth,
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: "Hello, ",
              style: TextStyle(
                fontSize: Dimensions.font20,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: user.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensions.font20,
                      color: Colors.black),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

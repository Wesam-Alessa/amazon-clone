import 'dart:convert';

import 'package:amazon_clone/constants/app_constants.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartServices {

  void removeFromCart({
    required BuildContext context,
    required ProductModel productModel,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse(
            AppConstants.BASE_URL + AppConstants.USER_REMOVE_PRODUCT_FROM_CART_URI + "/${productModel.id}"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userProvider.token,
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          UserModel userModel = userProvider.userModel.copyWith(
            cart: jsonDecode(response.body)['cart'],
          );
          userProvider.setUserModelFromModel(userModel);
          showSnackBar(context, 'Added Successfully');
        }, 
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

}

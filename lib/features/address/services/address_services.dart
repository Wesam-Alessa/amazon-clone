import 'dart:convert';

import 'package:amazon_clone/constants/app_constants.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {

  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse(AppConstants.BASE_URL + AppConstants.SAVE_USER_ADDRESS_URI),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userProvider.token,
        },
        body: jsonEncode({"address": address}),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          UserModel userModel = userProvider.userModel
              .copyWith(address: jsonDecode(response.body)['address']);
          userProvider.setUserModelFromModel(userModel);
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

   void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum
  }) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse(AppConstants.BASE_URL + AppConstants.USER_ORDER_URI),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userProvider.token,
        },
        body: jsonEncode({
          "address": address,
          'cart': userProvider.userModel.cart,
          'totalPrice': totalSum
          }),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Your order has been plased!");
          UserModel userModel = userProvider.userModel
              .copyWith(cart: []);
          userProvider.setUserModelFromModel(userModel);
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

}

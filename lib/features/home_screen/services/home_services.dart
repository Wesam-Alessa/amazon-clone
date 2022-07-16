import 'dart:convert';

import 'package:amazon_clone/constants/app_constants.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<ProductModel>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response response = await http.get(
          Uri.parse(AppConstants.BASE_URL +
              AppConstants.GET_PRODUCT_URI +
              '?category=$category'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'token': userProvider.token,
          });
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            productList.add(
              ProductModel.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<ProductModel> fetchDealOfDayProduct({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    ProductModel product = ProductModel(
      name: '',
      description: '',
      price: 0,
      quantity: 0,
      category: '',
      images: [],
    );
    try {
      http.Response response = await http.get(
        Uri.parse(
            AppConstants.BASE_URL + AppConstants.PRODUCT_DEAL_OF_DATE_URI),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userProvider.token,
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          product = ProductModel.fromJson(response.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}

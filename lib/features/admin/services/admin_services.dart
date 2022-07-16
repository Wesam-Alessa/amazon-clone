import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/app_constants.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required String price,
    required String quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("defjcngkm", "acclgs8t");
      List<String> imageUrls = [];
      for (File url in images) {
        CloudinaryResponse response = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(url.path, folder: name));
        imageUrls.add(response.secureUrl);
      }
      ProductModel productModel = ProductModel(
        name: name,
        description: description,
        price: double.parse(price),
        quantity: double.parse(quantity),
        category: category,
        images: imageUrls,
      );
      http.Response response = await http.post(
        Uri.parse(AppConstants.BASE_URL + AppConstants.ADMIN_ADD_PRODUCT_URI),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': Provider.of<UserProvider>(context, listen: false).token,
        },
        body: productModel.toJson(),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Product Added Successfully");
          Navigator.pop(context);
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  Future<List<ProductModel>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response response = await http.get(
          Uri.parse(AppConstants.BASE_URL + AppConstants.ADMIN_GET_PRODUCT_URI),
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

  void deleteProduct(
      {required BuildContext context,
      required ProductModel product,
      required VoidCallback onSuccess}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
            AppConstants.BASE_URL + AppConstants.ADMIN_DELETE_PRODUCT_URI),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': Provider.of<UserProvider>(context, listen: false).token,
        },
        body: jsonEncode({'id': product.id}),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  Future<List<OrderModel>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<OrderModel> orderList = [];
    try {
      http.Response response = await http.get(
          Uri.parse(AppConstants.BASE_URL + AppConstants.ADMIN_GET_ORDERS_URI),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'token': userProvider.token,
          });
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            orderList.add(
              OrderModel.fromJson(
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
    return orderList;
  }

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required OrderModel orderModel,
    required VoidCallback onSuccess,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
            AppConstants.BASE_URL + AppConstants.ADMIN_CHANGE_ORDER_STATUS_URI),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': Provider.of<UserProvider>(context, listen: false).token,
        },
        body: jsonEncode({'id': orderModel.id, 'status': status}),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<SalesModel> sales = [];
    int totalEarning = 0;
    try {
      http.Response response = await http.get(
          Uri.parse(
              AppConstants.BASE_URL + AppConstants.ADMIN_GET_ANALYTICS_URI),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'token': userProvider.token,
          });
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          var res = jsonDecode(response.body);
          totalEarning = res['totalEarnings'];
          sales = [
            SalesModel("Mobiles", res['mobilesEarnings']),
            SalesModel("Essentials", res['essentialEarnings']),
            SalesModel("Appliances", res['applianceEarnings']),
            SalesModel("Books", res['booksEarnings']),
            SalesModel("Fashion", res['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      "sales": sales,
      "totalEarnings": totalEarning,
    };
  }
}

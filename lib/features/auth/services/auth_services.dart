// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/app_constants.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  void signup(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppConstants.BASE_URL + AppConstants.REGISTRATION_URI),
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            "Account created! login with the same credentials!",
          );
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse(AppConstants.BASE_URL + AppConstants.LOGIN_URI),
        body: json.encode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          userProvider.setToken(response.headers['token']!);
          userProvider.setUserModel(
            response.body,
          );
          print("TOKEN:   " + response.headers['token'].toString());
          setSharedPreferences(
            AppConstants.TOKEN,
            response.headers['token']!,
          );
           Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      String token = await getSharedPreferences(AppConstants.TOKEN);
      if (token.isEmpty) {
        await setSharedPreferences(AppConstants.TOKEN, '');
      }

      http.Response tokenResponse = await http.post(
        Uri.parse(AppConstants.BASE_URL + AppConstants.AUTO_LOGIN_URI),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token
        },
      );

      var response = jsonDecode(tokenResponse.body);
      if (response == true) {
        http.Response userResponse = await http.get(
          Uri.parse(AppConstants.BASE_URL + AppConstants.AFTER_AUTO_LOGIN_URI),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token
          },
        );
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setToken(userResponse.headers['token']!);
        userProvider.setUserModel(userResponse.body);
      }
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  Future<bool> setSharedPreferences(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool success = await pref.setString(key, value);
    return success;
  }

  Future<String> getSharedPreferences(
    String key,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key) ?? '';
  }
}

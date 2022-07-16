import 'dart:convert';

import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _token = '';
  UserModel _userModel = UserModel(
      token: '',
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      cart: []);

  UserModel get userModel => _userModel;
  String get token => _token;

  void setUserModel(String userModel) {
    var user = jsonDecode(userModel);
    var cart = user['cart'];
    user['cart'] = [];
    user = jsonEncode(user);
    cart = jsonEncode(cart);
    _userModel = UserModel.fromJson(user);
    _userModel = _userModel.copyWith(
      cart: jsonDecode(cart),
    );
    setUserModelFromModel(_userModel);
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  void setUserModelFromModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }
}

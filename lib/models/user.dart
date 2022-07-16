// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazon_clone/models/cart.dart';

class UserModel {
  final String token;
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final List<dynamic> cart;

  UserModel({
    required this.token,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.cart,
  });

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UserModel.fromMap(Map<String, dynamic> map) {
    var userModel = UserModel(
      token: map['token'] ?? "",
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      cart: map['cart'] != []
          ? List<Map<String, dynamic>>.from(
              map['cart']?.map(
                (x) {
                  Map<String, dynamic>.from(x);
                },
              ),
            )
          : [],
    );
    return userModel;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'cart': cart
    };
  }

  String toJson() => json.encode(toMap());

  UserModel copyWith({
    String? token,
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    List<dynamic>? cart,
  }) {
    return UserModel(
      token: token ?? this.token,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      cart: cart ?? this.cart,
    );
  }
}

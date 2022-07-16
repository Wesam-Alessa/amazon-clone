import 'dart:convert';

import 'package:amazon_clone/models/product.dart';

class CartModel {
  ProductModel product;
  int quantity;
  String id;

  CartModel({required this.product, required this.quantity, required this.id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
      'id': id,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      product: ProductModel.fromMap(map['product'] as Map<String,dynamic>),
      quantity: map['quantity'] as int,
      id: map['_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) => CartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

import 'package:amazon_clone/models/rating.dart';

class ProductModel {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final List<dynamic> images;
  final String? id;
  final List<Rating>? rating;

  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.images,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'images': images,
      'id': id,
      'rating': rating
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      description: map['description'] as String,
      price: double.parse(map['price'].toString()),
      quantity: double.parse(map['quantity'].toString()),
      category: map['category'] as String,
      images: List<String>.from((map['images'] as List<dynamic>)),
      id: map['_id'],
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

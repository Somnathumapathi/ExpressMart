import 'dart:convert';

import 'package:expressmart/models/rating.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String productName;
  final String description;
  final double price;
  final double quantity;
  final List<String> imageUrls;
  final String category;
  final String? id;
  final String? userId;
  final List<Rating>? ratings;

  Product(
      {required this.productName,
      required this.description,
      required this.price,
      required this.quantity,
      required this.imageUrls,
      required this.category,
      this.id,
      this.userId,
      this.ratings});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'description': description,
      'price': price,
      'quantity': quantity,
      'imageUrls': imageUrls,
      'category': category,
      'id': id,
      'userId': userId,
      'ratings': ratings
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        productName: map['productName'] as String,
        description: map['description'] as String,
        price: map['price']?.toDouble() ?? 0.0,
        quantity: map['quantity']?.toDouble() ?? 0.0,
        imageUrls: List<String>.from((map['imageUrls'])),
        category: map['category'] as String,
        id: map['_id'],
        userId: map['userId'] != null ? map['userId'] as String : null,
        ratings: map['ratings'] != null
            ? List<Rating>.from(
                map['ratings']?.map(
                  (x) => Rating.fromMap(x),
                ),
              )
            : null);
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String productName;
  final String description;
  final double price;
  final double quantity;
  final List<String> imageUrls;
  final String category;
  final String? productId;
  final String? userId;

  Product(
      {required this.productName,
      required this.description,
      required this.price,
      required this.quantity,
      required this.imageUrls,
      required this.category,
      this.productId,
      this.userId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'description': description,
      'price': price,
      'quantity': quantity,
      'imageUrls': imageUrls,
      'category': category,
      'productId': productId,
      'userId': userId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['productName'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as double,
      imageUrls: List<String>.from((map['imageUrls'] as List<String>)),
      category: map['category'] as String,
      productId: map['productId'] != null ? map['productId'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
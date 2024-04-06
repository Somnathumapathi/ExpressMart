import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:expressmart/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:expressmart/constants/utils.dart';
import 'package:flutter/material.dart';

import '../secrets.dart';

class AdminServices {
  void sellProduct(
      {required BuildContext context,
      required String productName,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    try {
      final cloudinary = CloudinaryPublic(cloudName, uploadPresets);
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(images[i].path, folder: productName));
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
          productName: productName,
          description: description,
          price: price,
          quantity: quantity,
          imageUrls: imageUrls,
          category: category);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expressmart/common/widgets/customButton.dart';
// import 'package:expressmart/common/widgets/customTextField.dart';
import 'package:expressmart/constants/utils.dart';
import 'package:expressmart/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/customTextField1.dart';
import '../../../constants/global_variables.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({super.key});
  static const routeName = 'add-products';
  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  final adminServices = AdminServices();

  List<File> _images = [];
  void _pickImages() async {
    var res = await pickImage();
    setState(() {
      _images = res;
    });
  }

  String _category = 'Mobiles';
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final _addProductKey = GlobalKey<FormState>();
  void onSellProduct() {
    if (_addProductKey.currentState!.validate() && _images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          productName: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          category: _category,
          images: _images);
    }
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Products'),
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _images.isEmpty
                    ? InkWell(
                        child: Container(
                            // margin: const EdgeInsets.all(10),
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: GlobalVariables.secondaryColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_enhance,
                                ),
                                Text('Add images')
                              ],
                            )),
                        onTap: _pickImages,
                      )
                    : CarouselSlider(
                        items: _images.map((e) {
                          return Builder(
                              builder: (BuildContext context) => Image.file(
                                    e,
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ));
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField1(
                    controller: productNameController,
                    hintText: 'Product Name'),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField1(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField1(
                    controller: priceController, hintText: 'Price'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextField1(
                          controller: quantityController,
                          hintText: 'Quantity',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DropdownButton(
                          value: _category,
                          items: GlobalVariables.productCategories
                              .map((String prd) {
                            return DropdownMenuItem(
                              child: Text(prd),
                              value: prd,
                            );
                          }).toList(),
                          icon: Icon(Icons.arrow_drop_down),
                          onChanged: (val) {
                            setState(() {
                              _category = val!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                CustomButton(
                  text: 'Sell',
                  onTap: onSellProduct,
                  color: GlobalVariables.secondaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

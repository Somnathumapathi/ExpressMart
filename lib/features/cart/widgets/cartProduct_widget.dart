import 'package:expressmart/constants/global_variables.dart';
import 'package:expressmart/models/product.dart';
import 'package:expressmart/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  const CartProduct({super.key, required this.index});
  final int index;

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<UserProvider>().user.cart[widget.index];
    final cartProduct = Product.fromMap(cart['product']);
    final quantity = cart['quantity'];
    final isEligible = cartProduct.price >= 500 ? true : false;
    bool isInStock() {
      if (cartProduct.quantity > 0) {
        return true;
      } else {
        return false;
      }
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                cartProduct.imageUrls[0],
                fit: BoxFit.contain,
                height: 120,
                width: 120,
              ),
              Column(
                children: [
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      cartProduct.productName,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${cartProduct.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(left: 10),
                    child: isEligible
                        ? Text(
                            'Eligible for Free Shipping',
                            style: TextStyle(color: Colors.green),
                          )
                        : Text('Delivery charges are applicable',
                            style: TextStyle(color: Colors.yellow)),
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: isInStock()
                        ? Text(
                            'In Stock',
                            style: TextStyle(
                              color: Colors.teal,
                            ),
                          )
                        : Text(
                            'Out of Stock',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: GlobalVariables.secondaryColor, width: 1.5),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Text(
                          quantity.toString(),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

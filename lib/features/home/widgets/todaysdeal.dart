import 'package:expressmart/constants/global_variables.dart';
import 'package:flutter/material.dart';

class TodaysDeal extends StatefulWidget {
  const TodaysDeal({super.key});

  @override
  State<TodaysDeal> createState() => _TodaysDealState();
}

class _TodaysDealState extends State<TodaysDeal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
                text: 'Today\'s ',
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: 'Deals :',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold))
                ]),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: GlobalVariables.secondaryColor, width: 2)),
            child: Column(
              children: [
                Image.network(
                  'https://images-static.nykaa.com/media/catalog/product/5/8/5899b02NUT7370-02_1.jpg',
                  fit: BoxFit.cover,
                  width: 300,
                  height: 200,
                ),
                Text(
                  'Product name',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '\$999',
                  style: TextStyle(fontSize: 17, color: Colors.red),
                )
              ],
            ),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "See All >>",
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
    );
  }
}

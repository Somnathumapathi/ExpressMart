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
          Text('Today\'s Deal'),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: [
                Image.network(
                  'https://images-static.nykaa.com/media/catalog/product/5/8/5899b02NUT7370-02_1.jpg',
                  fit: BoxFit.cover,
                  height: 200,
                ),
                Text(
                  'Poduct name',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '\$999',
                  style: TextStyle(fontSize: 20, color: Colors.red),
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

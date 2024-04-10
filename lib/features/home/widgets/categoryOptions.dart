import 'package:expressmart/constants/global_variables.dart';
import 'package:expressmart/features/home/screens/category_screen.dart';
import 'package:flutter/material.dart';

class CategoryOptions extends StatelessWidget {
  const CategoryOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: GlobalVariables.categoryImages.length,
          itemExtent: 80,
          itemBuilder: (context, index) {
            final catImg = GlobalVariables.categoryImages[index]['image'];
            final catTit = GlobalVariables.categoryImages[index]['title'];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, CategoryScreen.routeName,
                    arguments: GlobalVariables.categoryImages[index]['title']);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          catImg!,
                          fit: BoxFit.cover,
                          height: 40,
                        ),
                      ),
                      Text(
                        catTit!,
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

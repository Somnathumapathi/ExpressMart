import 'package:expressmart/constants/global_variables.dart';
import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  OptionButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border:
                  Border.all(width: 1, color: GlobalVariables.secondaryColor),
              color: Color.fromARGB(255, 79, 78, 78)),
          height: 50,
          width: 160,
          child: Center(
              child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500),
          )),
        ),
        onTap: onPressed,
      ),
    );
  }
}

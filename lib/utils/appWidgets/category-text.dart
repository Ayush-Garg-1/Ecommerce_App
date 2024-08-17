import 'package:flutter/material.dart';

import '../themes/colors.dart';

class CategoryText extends StatelessWidget {
  String text;
  CategoryText({required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
          fontSize: 50,
          color: BLACK_COLOR),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class CustomCircleAvatar extends StatelessWidget {
  String? imagePath;
  CustomCircleAvatar({this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          FittedBox(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.4), blurRadius: 10)
                  ]),
              child: Center(
                child: Image.network(
                  imagePath!,
                  fit: BoxFit.fitHeight,
                  width: 70,
                  height: 70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

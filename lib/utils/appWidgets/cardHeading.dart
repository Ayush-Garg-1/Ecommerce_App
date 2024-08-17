import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardBoxHeading extends StatelessWidget {
  String? heading;
  CardBoxHeading({this.heading});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            heading!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
          CircleAvatar(
            radius: 17,
            backgroundColor:Theme.of(context).secondaryHeaderColor,
            child: IconButton(
              onPressed: () {

              },
              icon: Icon(
                Icons.arrow_forward,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

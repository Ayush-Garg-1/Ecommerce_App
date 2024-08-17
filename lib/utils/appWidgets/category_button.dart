import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
String? btnText;
IconData? icon;
VoidCallback? callback;
CategoryButton({this.btnText,this.icon,this.callback});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: () {
        callback!();
        },
        icon: Icon(icon, color: Theme.of(context).secondaryHeaderColor),
        label: Text(btnText.toString().toUpperCase()
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).secondaryHeaderColor,
          backgroundColor: Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
        ),
      ),
    );
  }
}

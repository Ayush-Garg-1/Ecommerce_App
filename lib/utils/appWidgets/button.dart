import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  String? buttonText;
  final VoidCallback? callback;
  Color? color;
  Color? btnTextColor;
  Color? btnBorderColor;
  CommonButton({this.buttonText,
    this.callback,
    this.color,
    this.btnTextColor=Colors.white,
    this.btnBorderColor=Colors.transparent
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: ElevatedButton(
        onPressed: () {
          callback!();
        },
        child: Text(buttonText ?? "Submit",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        style: ElevatedButton.styleFrom(
          foregroundColor: btnTextColor,
          backgroundColor: color!=null ? color :Color(0xd2ff5522),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
            color: btnBorderColor!,
            width: 2
          )
        ),
      ),
    );
  }
}

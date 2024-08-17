import 'package:flutter/material.dart';

showCustomSnackbar({context,message,color}){
  return ScaffoldMessenger.of(context)..removeCurrentSnackBar()
    ..showSnackBar(
    SnackBar(
        content: Center(child: Text(message,style: TextStyle(color:  Theme.of(context).secondaryHeaderColor,fontWeight: FontWeight.bold,fontSize: 17),)),
        backgroundColor: color,
      duration: Duration(seconds:1),
      behavior: SnackBarBehavior.floating, // Make it float with a margin
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
    )
  )
  ;
}
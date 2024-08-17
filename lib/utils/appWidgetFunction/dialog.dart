import 'dart:ffi';

import 'package:ecommerce/bloc/userScreenBloc/user_bloc.dart';
import 'package:ecommerce/models/cart_model.dart';
import 'package:ecommerce/models/products_model.dart';
import 'package:ecommerce/utils/appWidgets/button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/userScreenBloc/user_event.dart';
import '../../services/database_helper.dart';
import '../../services/shared_preference_service.dart';
import '../appWidgets/price-view-row.dart';

addImage({var userBloc, required ImageSource source, var context}) async {
  ImagePicker picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);
  if (pickedFile != null) {
    print(pickedFile.path);
    String? email = await SharedPreferenceService.getLoginUserEmail("email");
    await DataBaseHelper().setUserImage(pickedFile.path, email!);
    userBloc.add(FetchUserEvent());
    Navigator.pop(context);
  }
}

CustomDialog({context, required UserBloc userBloc}) {
  return showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          surfaceTintColor: Theme.of(context).secondaryHeaderColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 11,
          backgroundColor:  Theme.of(context).primaryColor,
          child: Container(
            height: 200,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      addImage(userBloc: userBloc,source: ImageSource
                          .gallery,context: context);
                    },
                    child: Icon(
                      Icons.camera,
                      size: 50,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      addImage(userBloc: userBloc,source: ImageSource
                          .camera,context: context);
                    },
                    child: Icon(
                      Icons.camera_alt_rounded,
                      size: 50,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ]),
          ),
        );
      });
}




productOrderDialog({context,required List<CartProductModel> products}) {
  num subTotal=0.0;
  products.forEach((product){
    num productPrice=product.price! * product.quantity!;
    subTotal = subTotal+productPrice;
  });
  return showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          surfaceTintColor: Theme.of(context).secondaryHeaderColor,
          elevation: 11,
          backgroundColor:  Theme.of(context).primaryColor,
          child:
          Container(
              height: 300,
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),

                decoration: BoxDecoration(
                  color:  Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "SUMMARY",
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PriceViewRow(
                    text: "Sub-Total",
                    price: subTotal.toStringAsFixed(2),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PriceViewRow(
                    text: "Shipping Fee",
                    price: 500.toString(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PriceViewRow(
                    text: "Total",
                    price:(subTotal+500).toStringAsFixed(2),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CommonButton(color: Theme.of(context).secondaryHeaderColor,btnTextColor:  Theme.of(context).primaryColor,buttonText: "CHECKOUT",),
                ],
              )),
        );
      });
}
import 'package:ecommerce/models/cart_model.dart';
import 'package:ecommerce/utils/appWidgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/cartBloc/cart_bloc.dart';
import '../../bloc/cartBloc/cart_event.dart';
import 'horizontal-space.dart';

 Widget CustomDismissibleWidget({required CartProductModel product,required CartBloc cartBloc}){
    return Dismissible(
      key: ValueKey(product.id),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cartBloc.add(DeleteCartProductEvent(id: product.id!));
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          padding: EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.5),
                  blurRadius: 5,
                )
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                "${product.images}",
                width: 100,
                height: 100,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      "${product.title}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  VerticalSpacing(size: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.price.toString(),
                        style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Text(
                        " * ${product.quantity.toString()}  =  ",
                        style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Text(
                        "${(product.price! * product.quantity!).toStringAsFixed(2)}",
                        style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      HorizontalSpacing(size: 3),
                      FaIcon(FontAwesomeIcons.indianRupeeSign,size: 12,color:Colors.green),
                      HorizontalSpacing(size: 3),
                    ],
                  ),
                  VerticalSpacing(size: 10),
                  Row(
                    children: [
                      Container(
                        width: 130,
                        decoration: BoxDecoration(
                            color: Color(0xfffef2cd),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  cartBloc.add(IncreaseProductQuentityEvent(id: product.id!));
                                  cartBloc.add(FetchCartProductEvent());
                                },
                                icon: Icon(Icons.add)
                            ),
                            Text(
                              product.quantity.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                onPressed: () {
                                  if(product.quantity! > 1){
                                    cartBloc.add(DecreaseProductQuentityEvent(id: product.id!));
                                    cartBloc.add(FetchCartProductEvent());
                                  }
                                },
                                icon: Icon(Icons.remove)
                            ),
                          ],
                        ),
                      ),
                      HorizontalSpacing(size: 40),
                      InkWell(
                          onTap: () async {
                            cartBloc.add(DeleteCartProductEvent(id: product.id!));
                          },
                          child: Icon(
                            Icons.delete,
                            size: 35,
                            color: Colors.red,
                          )
                      ),
                    ],
                  ),
                  VerticalSpacing(size: 10),
                ],
              ),
            ],
          )
      ),
    );
}

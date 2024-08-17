import 'package:ecommerce/bloc/cartBloc/cart_bloc.dart';
import 'package:ecommerce/bloc/cartBloc/cart_event.dart';
import 'package:ecommerce/bloc/cartBloc/cart_state.dart';
import 'package:ecommerce/utils/appWidgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/products_model.dart';
import '../utils/appWidgetFunction/snackbar.dart';
import '../utils/appWidgets/horizontal-space.dart';
import '../utils/appWidgets/vertical_space.dart';
import '../utils/themes/colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductModel? product;
  @override
  Widget build(BuildContext context) {
    product = ModalRoute.of(context)!.settings.arguments as ProductModel;
    double totalprice = double.parse((product!.price! +
            ((product!.price! * product!.discountPercentage!) / 100))
        .toStringAsFixed(2));

    return BlocProvider(
      create: (_) => CartBloc(),
      child: Scaffold(
        body: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) async {

            if (state is ProductAddSuccessState) {
              showCustomSnackbar(
                context: context,
                message: state.message,
                color: Theme.of(context).primaryColor,
              );
              await Future.delayed(Duration(milliseconds: 1200));
              Navigator.pushReplacementNamed(context, "/layout-screen");
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 25, top: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    color: Theme.of(context).secondaryHeaderColor,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, "/layout-screen");
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Theme.of(context).secondaryHeaderColor,
                                    size: 15,
                                  ),
                                ),
                              ),
                              Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).secondaryHeaderColor,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).primaryColor, blurRadius: 3)
                                    ]),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${product!.rating}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Icon(Icons.star, color: Theme.of(context).primaryColor),
                                    ]),
                              )
                            ],
                          ),
                        ),
                        Hero(
                          tag: "image-animation${product!.id}",
                          child: Image.network(
                            product!.thumbnail ?? "",
                            height: 300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: LITE_BLACK_COLOR,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VerticalSpacing(size: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product!.category.toString().toUpperCase(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).secondaryHeaderColor),
                              ),
                              Container(
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                        product!.brand.toString() == "null"
                                            ? "smart shop"
                                            : product!.brand.toString(),
                                        style: TextStyle(
                                            color: Theme.of(context).secondaryHeaderColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ))
                            ],
                          ),
                          VerticalSpacing(size: 25),
                          Text(
                            product!.title.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.bold),
                          ),
                          VerticalSpacing(size: 25),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                          VerticalSpacing(size: 20),
                          Text(
                            product!.description.toString(),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.bold),
                          ),
                          VerticalSpacing(size: 15),
                          Text(
                            "${product!.warrantyInformation.toString()} & ${product!.returnPolicy.toString()}",
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.bold),
                          ),
                          VerticalSpacing(size: 15),
                          Row(
                            children: [
                              Text(
                                totalprice.toString(),
                                style: TextStyle(
                                    color: Theme.of(context).secondaryHeaderColor,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Theme.of(context).secondaryHeaderColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              HorizontalSpacing(size: 10),
                              Text(
                                product!.price.toString(),
                                style: TextStyle(
                                    color: Theme.of(context).secondaryHeaderColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              HorizontalSpacing(size: 5),
                              FaIcon(
                                FontAwesomeIcons.indianRupeeSign,
                                color: Theme.of(context).secondaryHeaderColor,
                                size: 17,
                              )
                            ],
                          ),
                          VerticalSpacing(size: 5),
                          Text(
                            "Min. ${product!.discountPercentage} Off",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          VerticalSpacing(size: 15),
                          Text(
                            "Avaliable Stock : ${product!.stock}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.bold),
                          ),
                          VerticalSpacing(size: 40),
                          Center(
                              child: CommonButton(
                            buttonText: "ADD TO CART",
                            color: Theme.of(context).primaryColor,
                            callback: () async {
                              context
                                  .read<CartBloc>()
                                  .add(AddProductEvent(product: product!));
                            },
                          )),
                          VerticalSpacing(size: 30),
                        ]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

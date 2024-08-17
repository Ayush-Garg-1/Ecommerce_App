import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/products_model.dart';

class CustomImageCarouselSlider extends StatelessWidget {
  List<ProductModel> products;

  CustomImageCarouselSlider({required this.products});
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = products.map((product) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(

            color: Theme.of(context).secondaryHeaderColor, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Center(
              child: Image.network(
                product.thumbnail!,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(color: Theme.of(context).primaryColor, blurRadius: 3)
                      ]),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${product.rating!}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Icon(Icons.star, color: Theme.of(context).primaryColor),
                      ]),
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/product-details-screen",arguments: product);

                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).secondaryHeaderColor,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ) as Widget;
    }).toList();
    return CarouselSlider(
      items: widgets,
      options: CarouselOptions(
          height: 300,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 1),
    );
  }
}

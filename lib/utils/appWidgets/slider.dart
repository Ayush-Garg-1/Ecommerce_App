import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatelessWidget {
  List<String>? images;
  CustomCarouselSlider({this.images});
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = images!.map((image) {
      return Container(
        child: Image.asset(image,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: double.infinity),
      ) as Widget;
    }).toList();
    return CarouselSlider(
      items: widgets,
      options: CarouselOptions(
        height: 230,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 1,
      ),
    );
  }
}

import 'package:ecommerce/utils/appWidgets/horizontal-space.dart';
import 'package:ecommerce/utils/appWidgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BigProductCard extends StatelessWidget {
  String? imageUrl;
  String? title;
  double? discount;
  double? price;
  BigProductCard({this.imageUrl, this.title, this.discount,this.price});
  @override
  Widget build(BuildContext context) {
     double totalprice = double.parse((price! +  ((price!*discount!)/100)).toStringAsFixed(2));
    return Container(
      width: MediaQuery.of(context).size.width*0.47,
        child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, children: [
        VerticalSpacing(size: 5),
        Image.network(
          width: MediaQuery.of(context).size.width,
          imageUrl!,
          height: 170,
          fit: BoxFit.fitHeight,
        ),
        VerticalSpacing(size: 5),
        Text(
          title!,
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        VerticalSpacing(size: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              totalprice.toString(),
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            HorizontalSpacing(size: 10),
            Text(
              price.toString(),
              style: TextStyle(

                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            HorizontalSpacing(size: 2),
            FaIcon(FontAwesomeIcons.indianRupeeSign,size: 12,),
          ],
        ),
        VerticalSpacing(size: 5),
        Text(
          "Min. $discount Off",
          style: TextStyle(
              color: Color(0xff0eb013),
              fontWeight: FontWeight.bold,
              fontSize: 17),
        ),
        VerticalSpacing(size: 10),
      ]),
    ));
  }
}

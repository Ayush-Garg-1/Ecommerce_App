import 'package:ecommerce/utils/appWidgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../themes/colors.dart';

class SmallProductCard extends StatelessWidget {
  String? imageUrl;
  String? title;
  String? content;
  SmallProductCard({this.imageUrl, this.title, this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.3,
        height: MediaQuery.of(context).size.height*0.22,
        child: Card(
          elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color:  Theme.of(context).secondaryHeaderColor,
      child: Column(children: [
        Container(
          width:MediaQuery.of(context).size.width ,
          height: MediaQuery.of(context).size.height*0.12,
            color: LITE_RED_COLOR1, child: Image.network(imageUrl!)
        ),
        VerticalSpacing(size: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title!,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        SizedBox(
          height: 3,
        ),
       Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [ Text(
         "$content",
         style: TextStyle(color:SUCCESS_COLOR,fontWeight: FontWeight.bold, fontSize: 12),
       ),
         FaIcon(FontAwesomeIcons.indianRupeeSign,size: 12,color:SUCCESS_COLOR),],),
        SizedBox(
          height: 6,
        )
      ]),
    ));
  }
}

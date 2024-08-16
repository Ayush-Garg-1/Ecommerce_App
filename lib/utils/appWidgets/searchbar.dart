import 'package:flutter/material.dart';

import '../../models/products_model.dart';
import '../../services/database_helper.dart';

class CustomSearchBar extends StatelessWidget {
  Function(List<ProductModel>) getProducts;
  CustomSearchBar({required this.getProducts});

  @override
  Widget build(BuildContext context) {
    return
      Container(
      width: MediaQuery.of(context).size.width*0.7,
      child: TextField(
        onChanged: (value) async{
          List<ProductModel> products = await DataBaseHelper().getProductsBasedOnSearch(value);
        getProducts(products);
          },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          hintText: "Search ...",

          hintStyle: TextStyle(fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: Colors.orange,
                  width: 3,
            ),
          ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Colors.orange,
                width: 3,
              ),
            )
        ),
      ),
    );
  }
}

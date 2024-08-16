import 'package:flutter/material.dart';
import '../../models/products_model.dart';

class CategoriesView extends StatelessWidget {
  List<ProductModel> products = [];
  Color color;
  CategoriesView({required this.products, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: color,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Wrap(
          spacing: 10,
          runSpacing: 20,
          children: products.map((product) {
            return InkWell(
              onTap: () {

              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.orange.withOpacity(0.4), blurRadius: 5)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Image.network(
                          product.thumbnail ?? "",
                          height: 100,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          product.title.toString(),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Price: ${product.price.toString()}",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )
                    ]),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart';

import '../models/products_model.dart';
import 'database_helper.dart';

class ProductDataService {
  static Future getProductsData() async {
    try {
      Response response =
          await get(Uri.parse("https://dummyjson.com/products"));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Extract the products list from the response
        List<dynamic> productData = jsonResponse['products'];
        List<ProductModel> productsDataList = [];

        productData.forEach((element) {
          element["price"] =  (double.parse((element["price"]*83.95).toStringAsFixed(2)));
          element["price"] = double.parse((element["price"] -  ((element["price"]*element["discountPercentage"])/100)).toStringAsFixed(2));
          element["images"] = element["images"][0];
          ProductModel product = ProductModel.fromJson(element);
          productsDataList.add(product);
        });
        await DataBaseHelper().insertProducts(productsDataList);
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print("Fetchind Product Exception");
    }
  }
}

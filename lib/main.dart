import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/explore_screen.dart';
import 'package:ecommerce/screens/layout_screen.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/screens/splash_screen.dart';


import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/login-screen":(context)=>LoginScreen(),
        "/signup-screen":(context)=>SignupScreen(),
        "/layout-screen":(context)=> LayoutScreen(),
        "/explore-screen":(context)=> ExploreScreen(),
        "/cart-screen":(context)=> CartScreen(),
        "/product-details-screen":(context)=>ProductDetailsScreen()
      },
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
}

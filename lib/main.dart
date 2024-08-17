import 'package:ecommerce/screens/splash_screen.dart';
import 'package:ecommerce/utils/Routes/routes.dart';
import 'package:ecommerce/utils/themes/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: applicationTheme(),
      routes: applicationRoutes(context),
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
}


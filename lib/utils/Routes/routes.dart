import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/explore_screen.dart';
import 'package:ecommerce/screens/layout_screen.dart';
import 'package:ecommerce/screens/product_details_screen.dart';

import '../../screens/login_screen.dart';
import '../../screens/signup_screen.dart';

applicationRoutes(var context) {
  final String LOGIN_SCREEN = "/login-screen";
  final String SIGNUP_SCREEN = "/signup-screen";
  final String LAYOUT_SCREEN = "/layout-screen";
  final String EXPLORE_SCREEN = "/explore-screen";
  final String CART_SCREEN = "/cart-screen";
  final String PRODUCT_DETAILS_SCREEN = "/product-details-screen";

  return {
    LOGIN_SCREEN: (context) => LoginScreen(),
    SIGNUP_SCREEN: (context) => SignupScreen(),
    LAYOUT_SCREEN: (context) => LayoutScreen(),
    EXPLORE_SCREEN: (context) => ExploreScreen(),
    CART_SCREEN: (context) => CartScreen(),
    PRODUCT_DETAILS_SCREEN: (context) => ProductDetailsScreen()
  };
}

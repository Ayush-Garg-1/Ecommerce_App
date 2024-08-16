import 'package:ecommerce/models/cart_model.dart';

abstract class CartState {}

final class CartInitialState extends CartState {}

final class ProductAddSuccessState extends CartState{
  String message;
  ProductAddSuccessState({required this.message});
}

final class CartLoadingState extends CartState{}

final class EmptyCartProductsState extends CartState{
  String message;
  EmptyCartProductsState({required this.message});
}

final class CartProductLoadedState extends CartState{
  List<CartProductModel> products;
  CartProductLoadedState({required this.products});
}

final class CartProductDeleteState extends CartState{
  String message;
  CartProductDeleteState({required this.message});
}
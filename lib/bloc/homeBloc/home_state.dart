import '../../models/products_model.dart';

abstract class HomeState {}


class ProductInitialState extends HomeState {}

class ProductLoadingState extends HomeState {}

class ProductLoadedState extends HomeState {
  List<ProductModel>? products;

  ProductLoadedState(this.products);
}

class ProductErrorState extends HomeState {
  final String message;
  ProductErrorState(this.message);
}

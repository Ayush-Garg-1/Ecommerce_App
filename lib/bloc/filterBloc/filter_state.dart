import 'package:ecommerce/models/products_model.dart';

abstract class FilterState {}

final class FilterInitialState extends FilterState {}

final class FilterProductLoadingState extends FilterState{
}

final class FilterProductLoadedState extends FilterState{
  List<ProductModel> products;
  FilterProductLoadedState({required this.products});
}

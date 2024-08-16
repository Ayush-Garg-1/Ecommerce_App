
import 'package:ecommerce/models/products_model.dart';

abstract class CartEvent {}

class AddProductEvent extends CartEvent{
  ProductModel product;
  AddProductEvent({required this.product});
}

class FetchCartProductEvent extends CartEvent{
}


class IncreaseProductQuentityEvent extends CartEvent{
  int id;
  IncreaseProductQuentityEvent({required this.id});
}

class DecreaseProductQuentityEvent extends CartEvent{
  int id;
  DecreaseProductQuentityEvent({required this.id});
}

class DeleteCartProductEvent extends CartEvent{
  int id;
  DeleteCartProductEvent({required this.id});
}


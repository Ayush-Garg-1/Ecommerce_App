import 'package:bloc/bloc.dart';
import 'package:ecommerce/models/cart_model.dart';
import 'package:ecommerce/services/database_helper.dart';

import 'cart_event.dart';
import 'cart_state.dart';


class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {

    on<AddProductEvent>((event, emit) async {
      await DataBaseHelper().insertCartProduct(event.product);
      emit(ProductAddSuccessState(message: "Product Added"));
    });


    on<FetchCartProductEvent>((event,emit) async{
      emit(CartLoadingState());
      List<CartProductModel> products = await DataBaseHelper().getCartProducts();
      if(products.isEmpty){
        emit(EmptyCartProductsState(message: "Cart Is Empty"));
      }else{
        emit(CartProductLoadedState(products: products));
      }
    });

    on<IncreaseProductQuentityEvent>((event, emit) async {
      await DataBaseHelper().increaseProductQuentity(event.id);
    });

    on<DecreaseProductQuentityEvent>((event, emit) async {
      await DataBaseHelper().decreaseProductQuentity(event.id);
    });

    on<DeleteCartProductEvent>((event, emit) async {
      await DataBaseHelper().deletecartProduct(event.id);
      emit(CartProductDeleteState(message: "Product Deleted"));
    });

  }
}

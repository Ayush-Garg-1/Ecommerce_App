import 'package:bloc/bloc.dart';
import 'package:ecommerce/bloc/homeBloc/home_state.dart';
import 'package:ecommerce/models/products_model.dart';
import 'package:ecommerce/services/database_helper.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {


  Future<List<ProductModel>> getCategoryWiseProducts(String category,limit) async {
    return  await DataBaseHelper().getCategoryWiseProducts(category,limit);
  }


  HomeBloc() : super(ProductInitialState()){
   on<FetchProductsEvent>((event,emit) async{
     emit(ProductLoadingState());
     try{
       List<ProductModel> products = await DataBaseHelper().getProducts();

       emit(ProductLoadedState(products));
     }catch(e){
       emit(ProductErrorState(e.toString()));
     }
   });
  }
}

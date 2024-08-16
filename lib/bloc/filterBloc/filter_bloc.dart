import 'package:bloc/bloc.dart';
import 'package:ecommerce/bloc/filterBloc/filter_event.dart';
import 'package:ecommerce/models/products_model.dart';
import 'package:ecommerce/services/database_helper.dart';

import 'filter_state.dart';


class FilterBloc extends Bloc<FilterEvent, FilterState> {
  double lowerValue = 0.0;
  double upperValue = 1500.0;

  FilterBloc() : super(FilterInitialState()) {

    on<FetchAllProductEvent>((event, emit) async {
      emit(FilterProductLoadingState());
      List<ProductModel> products = await DataBaseHelper().getProducts();
      emit(FilterProductLoadedState(products: products));
    });

    on<FetchSearchProductEvent>((event, emit) async {
      List<ProductModel> products;
      if(event.searchValue == null){
         products = await DataBaseHelper().getProducts();
      }else {
        products = await DataBaseHelper()
            .getProductsBasedOnSearch(event.searchValue!);
      }
      emit(FilterProductLoadedState(products: products));
    });

    on<FetchDropDownProductEvent>((event, emit) async {
      List<ProductModel> products = await DataBaseHelper().getProductBasedOnFilter(event.dropdownValue!);
      emit(FilterProductLoadedState(products: products));
    });

    on<FetchCategoryProductEvent>((event, emit) async {
      List<ProductModel> products = await DataBaseHelper().getCategoryWiseProducts(event.category!, false);
      emit(FilterProductLoadedState(products: products));
    });


  }
}

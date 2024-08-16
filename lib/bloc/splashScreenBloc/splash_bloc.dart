import 'package:bloc/bloc.dart';
import 'package:ecommerce/bloc/splashScreenBloc/splash_event.dart';
import 'package:ecommerce/bloc/splashScreenBloc/splash_state.dart';

import '../../services/fetch_products.dart';


class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<SplashStartEvent>((event, emit) async {
      emit(SplashStartState());
      await ProductDataService.getProductsData();
      await Future.delayed(Duration(seconds: 2));
      emit(SplashCompleteState());
    });
  }
}

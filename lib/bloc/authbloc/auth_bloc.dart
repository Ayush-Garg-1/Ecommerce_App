import 'package:bloc/bloc.dart';

import '../../services/database_helper.dart';
import '../../services/shared_preference_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<SignupSubmittedEvent>((event, emit) async {
      Map<String, dynamic> user = {
        "image": "assets/images/user.png",
        "name": event.name,
        "email": event.email,
        "phone": event.phone,
        "password": event.password,
      };
      int status = await DataBaseHelper().insertUser(user);
      if(status==200){
        emit(AuthSuccessState(message: "User register successfully"));
      }else if(status==300){
        emit(AuthFailureState(message: "User already exist"));
      }else{
        emit(AuthFailureState(message: "User Not Registered"));
      }
    });
    on<LoginSubmittedEvent>((event,emit) async{
      int status = await DataBaseHelper().checkUserLogin(event.email!, event.password!);
      if(status==200){
        await SharedPreferenceService.setUserLogin("IsLogin", true);
        await SharedPreferenceService.setLoginUserEmail("loginUserEmail",event.email!);
        emit(AuthSuccessState(message: "User login successfully..."));
      }else if(status==300){
        emit(AuthFailureState(message: "Invalid user details"));
      }else{
        emit(AuthFailureState(message: "User Login Error"));
      }
    });
  }
}

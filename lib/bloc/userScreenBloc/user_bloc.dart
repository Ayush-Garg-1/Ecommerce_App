import 'package:bloc/bloc.dart';
import 'package:ecommerce/bloc/userScreenBloc/user_event.dart';
import 'package:ecommerce/bloc/userScreenBloc/user_state.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:ecommerce/services/database_helper.dart';
import 'package:ecommerce/services/shared_preference_service.dart';
import 'package:package_info_plus/package_info_plus.dart';



class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState())  {
    on<FetchUserEvent>((event, emit)async {
      String? email = await SharedPreferenceService.getLoginUserEmail("email");
      UsersModel user = await DataBaseHelper().getLoginUserInfo(email!);
      final packageInfo = await PackageInfo.fromPlatform();
      String? version = packageInfo.version.toString();
      emit(LoadedUserState(user: user,appVersion:version));
    });

    on<LogoutUserEvent>((event, emit)async {
      await SharedPreferenceService.setLoginUserEmail("email", "");
      await SharedPreferenceService.setUserLogin("IsLogin", false);
      emit(UserLogoutState());
    });


  }
}

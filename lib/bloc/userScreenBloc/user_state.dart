import '../../models/user_model.dart';

abstract class UserState {}

final class UserInitialState extends UserState {}
final class LoadingState extends UserState {}

final class LoadedUserState extends UserState {
  UsersModel user;
  String? appVersion;
  LoadedUserState({required this.user,this.appVersion});
}

final class UserLogoutState extends UserState {}

final class UserEditState extends UserState {
  UsersModel user;
  UserEditState({required this.user});
}
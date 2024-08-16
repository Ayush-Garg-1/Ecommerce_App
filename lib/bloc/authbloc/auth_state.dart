
abstract class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState{}

final class AuthSuccessState extends AuthState{
  String message="";
  AuthSuccessState({required this.message});
}

final class AuthFailureState extends AuthState{
  String message="";
  AuthFailureState({required this.message});
}

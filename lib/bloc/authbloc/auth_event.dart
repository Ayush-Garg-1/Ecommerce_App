
abstract class AuthEvent {}

final class SignupSubmittedEvent extends  AuthEvent{
 String? name;
 String? email;
 String? phone;
 String? password;

 SignupSubmittedEvent({this.name,this.email,this.phone,this.password});
}

final class LoginSubmittedEvent extends  AuthEvent{
  String? email;
  String? password;

  LoginSubmittedEvent({this.email,this.password});
}

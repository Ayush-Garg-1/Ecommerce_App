import 'package:ecommerce/bloc/authbloc/auth_bloc.dart';
import 'package:ecommerce/bloc/authbloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/authbloc/auth_state.dart';
import '../utils/appWidgetFunction/snackbar.dart';
import '../utils/appWidgets/vertical_space.dart';
import '../utils/appWidgets/button.dart';
import '../utils/appWidgets/textfeild.dart';

class SignupScreen extends StatelessWidget {
  String email = "";
  String password = "";
  String phone = "";
  String name = "";
  var form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: Scaffold(// Ensure resizing when keyboard appears
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthSuccessState) {
              showCustomSnackbar(context: context, message: state.message, color: Colors.green);
              await Future.delayed(Duration(milliseconds: 1700));
              Navigator.pushReplacementNamed(context, "/login-screen");
            } else if (state is AuthFailureState) {
              showCustomSnackbar(context: context, message: state.message, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xfffda37e), Colors.orange],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(120)),
                          image: DecorationImage(
                            image: AssetImage('assets/images/signup.jpg'),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Form(
                              key: form_key,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  VerticalSpacing(size: 15),
                                  CustomTextFeild(
                                    label: "Name",
                                    getValue: (value) {
                                      name = value;
                                    },
                                  ),
                                  VerticalSpacing(size: 20),
                                  CustomTextFeild(
                                    label: "Email",
                                    getValue: (value) {
                                      email = value;
                                    },
                                    emailValidate: true,
                                  ),
                                  VerticalSpacing(size: 20),
                                  CustomTextFeild(
                                    label: "Phone",
                                    getValue: (value) {
                                      phone = value;
                                    },
                                    phoneValidate: true,
                                    maxLength: 10,
                                    keyBoardType: TextInputType.number,
                                  ),
                                  VerticalSpacing(size: 20),
                                  CustomTextFeild(
                                    label: "Password",
                                    getValue: (value) {
                                      password = value;
                                    },
                                    keyBoardType: TextInputType.visiblePassword,
                                  ),
                                  VerticalSpacing(size: 50),
                                  CommonButton(
                                    buttonText: "CREATE ACCOUNT",
                                    callback: () async {
                                      FocusScope.of(context).unfocus();
                                      if (form_key.currentState!.validate()) {
                                        context.read<AuthBloc>().add(SignupSubmittedEvent(
                                          name: name,
                                          email: email,
                                          phone: phone,
                                          password: password,
                                        ));
                                      }
                                    },
                                  ),
                                  SizedBox(height: 30),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(context, "/login-screen");
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Have an account?  ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "Login",
                                            style: TextStyle(
                                              fontSize: 15,
                                              decoration: TextDecoration.underline,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:ecommerce/bloc/authbloc/auth_bloc.dart';
import 'package:ecommerce/bloc/authbloc/auth_event.dart';
import 'package:ecommerce/utils/appWidgetFunction/snackbar.dart';
import 'package:ecommerce/utils/appWidgets/Circular_progress_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authbloc/auth_state.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/shared_preference_service.dart';
import '../utils/appWidgets/vertical_space.dart';

import '../utils/appWidgets/button.dart';
import '../utils/appWidgets/textfeild.dart';

class LoginScreen extends StatelessWidget {
  String email = "";
  String password = "";

  var form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthSuccessState) {
              await SharedPreferenceService.setLoginUserEmail("email", email);
              showCustomSnackbar(context: context, message: state.message, color: Colors.green);
              await Future.delayed(Duration(milliseconds: 1700));
              Navigator.pushReplacementNamed(context, "/layout-screen");
            } else if (state is AuthFailureState) {
              showCustomSnackbar(context: context, message: state.message, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return CustomCircularProgressIndicator();
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
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(120)),
                          image: DecorationImage(
                            image: AssetImage('assets/images/login.jpg'),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Form(
                              key: form_key,
                              child: Column(
                                children: [
                                  CustomTextFeild(
                                    label: "Email",
                                    getValue: (value) {
                                      email = value;
                                    },
                                    emailValidate: true,
                                  ),
                                  VerticalSpacing(size: 20),
                                  CustomTextFeild(
                                    label: "Password",
                                    getValue: (value) {
                                      password = value;
                                    },
                                    keyBoardType: TextInputType.number,
                                  ),
                                  VerticalSpacing(size: 30),
                                  CommonButton(
                                    buttonText: "LOGIN",
                                    callback: () async {
                                      FocusScope.of(context).unfocus();
                                      if (form_key.currentState!.validate()) {
                                        context.read<AuthBloc>().add(LoginSubmittedEvent(email: email, password: password));
                                      }
                                    },
                                  ),
                                  SizedBox(height: 30),
                                  SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FaIcon(FontAwesomeIcons.google, size: 30, color: Colors.white),
                                      FaIcon(FontAwesomeIcons.phone, size: 28, color: Colors.white),
                                      FaIcon(FontAwesomeIcons.instagram, size: 30, color: Colors.white),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.pushReplacementNamed(context, "/signup-screen");
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Don't have an account?  ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "SignUp",
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

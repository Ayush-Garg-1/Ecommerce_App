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
import '../utils/themes/colors.dart';

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
              showCustomSnackbar(context: context, message: state.message, color: SUCCESS_COLOR);
              await Future.delayed(Duration(milliseconds: 1700));
              Navigator.pushReplacementNamed(context, "/layout-screen");
            } else if (state is AuthFailureState) {
              showCustomSnackbar(context: context, message: state.message, color: FAILURE_COLOR);
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
                    colors: [Theme.of(context).primaryColorDark, Theme.of(context).primaryColor],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(120)),
                          image: DecorationImage(
                            image: AssetImage('assets/images/login.jpg'),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            VerticalSpacing(size: 60),
                            Text(
                              'Welcome!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:Theme.of(context).secondaryHeaderColor,
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

                                  SizedBox(height: 50),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FaIcon(FontAwesomeIcons.google, size: 30, color:Theme.of(context).secondaryHeaderColor),
                                      FaIcon(FontAwesomeIcons.phone, size: 28, color:Theme.of(context).secondaryHeaderColor),
                                      FaIcon(FontAwesomeIcons.instagram, size: 30, color:Theme.of(context).secondaryHeaderColor),
                                    ],
                                  ),
                                  SizedBox(height: 40),
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
                                          color:Theme.of(context).secondaryHeaderColor,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "SignUp",
                                            style: TextStyle(
                                              fontSize: 15,
                                              decoration: TextDecoration.underline,
                                              fontWeight: FontWeight.bold,
                                              color:Theme.of(context).secondaryHeaderColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            VerticalSpacing(size: 40),
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

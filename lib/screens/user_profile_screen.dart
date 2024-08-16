import 'dart:io';
import 'package:ecommerce/utils/appWidgetFunction/dialog.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/bloc/userScreenBloc/user_bloc.dart';
import 'package:ecommerce/bloc/userScreenBloc/user_event.dart';
import 'package:ecommerce/bloc/userScreenBloc/user_state.dart';
import 'package:ecommerce/utils/appWidgets/Circular_progress_indicator.dart';
import 'package:ecommerce/utils/appWidgets/button.dart';
import 'package:ecommerce/utils/appWidgets/horizontal-space.dart';
import 'package:ecommerce/utils/appWidgets/vertical_space.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserBloc()..add(FetchUserEvent()),
      child: Scaffold(
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) async {
            if (state is UserLogoutState) {
              Navigator.pushReplacementNamed(context, "/login-screen");
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return CustomCircularProgressIndicator();
            } else if (state is LoadedUserState) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.withOpacity(0.3),
                      Colors.yellow.withOpacity(0.3),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        VerticalSpacing(size: 70),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundImage: state.user.image.toString() !=
                                        "assets/images/user.png"
                                    ? FileImage(
                                        File(state.user.image.toString()))
                                    : AssetImage(state.user.image.toString()),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: InkWell(
                                  onTap: () {
                                    CustomDialog(context: context, userBloc: BlocProvider.of<UserBloc>(context));
                                  },
                                  child: CircleAvatar(
                                    radius: 17,
                                    backgroundColor: Colors.orangeAccent,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalSpacing(size: 70),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildContactInfo(
                                    Icons.person, state.user.name.toString()),
                                buildContactInfo(
                                    Icons.email, state.user.email.toString()),
                                buildContactInfo(
                                    Icons.phone, state.user.phone.toString()),
                                VerticalSpacing(size: 55),
                                CommonButton(
                                  buttonText: "Edit Profile",
                                  color: Colors.orange,
                                ),
                                VerticalSpacing(size: 20),
                                CommonButton(
                                  buttonText: "Logout",
                                  color: Colors.orange,
                                  callback: () {
                                    context
                                        .read<UserBloc>()
                                        .add(LogoutUserEvent());
                                  },
                                ),
                                VerticalSpacing(size: 20),
                                Text("Version : ${state.appVersion}"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
              );
            }
          },
        ),
      ),
    );
  }




  Widget buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.orangeAccent),
          HorizontalSpacing(size: 10),
          Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

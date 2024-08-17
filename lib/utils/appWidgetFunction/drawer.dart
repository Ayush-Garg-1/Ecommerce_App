import 'dart:io';

import 'package:ecommerce/bloc/userScreenBloc/user_bloc.dart';
import 'package:ecommerce/bloc/userScreenBloc/user_event.dart';
import 'package:ecommerce/utils/appWidgets/Circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/userScreenBloc/user_state.dart';
import '../../services/shared_preference_service.dart';
import 'dialog.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      UserBloc()
        ..add(FetchUserEvent()),
      child:
      BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if(state is LoadedUserState){
            return Drawer(
              child: ListView(
                children: [
                  Container(
                    height: 200,
                    child: UserAccountsDrawerHeader(

                      decoration: BoxDecoration(
                          color:  Theme.of(context).primaryColor),
                      currentAccountPicture:     CircleAvatar(
                        radius: 60,
                        backgroundColor:  Theme.of(context).secondaryHeaderColor,
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
                                  backgroundColor:  Theme.of(context).secondaryHeaderColor,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 17,
                                    color:  Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      accountName: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(state.user.name.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).secondaryHeaderColor
                          ),
                        ),
                      ),
                      accountEmail: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(state.user.email.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                              color: Theme.of(context).secondaryHeaderColor
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.home,
                    ),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/layout-screen");
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout_rounded,
                    ),
                    title: const Text('Logout'),
                    onTap: () async {
                      context
                          .read<UserBloc>()
                          .add(LogoutUserEvent());
                      Navigator.pushReplacementNamed(context, "/login-screen");
                    },
                  ),
                  AboutListTile(
                    // <-- SEE HERE
                    icon: Icon(
                      Icons.info,
                    ),
                    child: Text('About app'),
                    applicationIcon: Icon(
                      Icons.local_play,
                    ),
                    applicationName: 'Ecommerce App',
                    applicationVersion: state.appVersion.toString(),
                    applicationLegalese: '© 2024 company name',
                  ),
                ],
              ),
            );
          }
          return CustomCircularProgressIndicator();
        },
      ),
    );
  }
}



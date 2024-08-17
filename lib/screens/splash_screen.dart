import 'package:ecommerce/bloc/splashScreenBloc/splash_bloc.dart';
import 'package:ecommerce/bloc/splashScreenBloc/splash_event.dart';
import 'package:ecommerce/bloc/splashScreenBloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/shared_preference_service.dart';
import '../utils/themes/colors.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_)=>SplashBloc()..add(SplashStartEvent()),
      child: Scaffold(
        body: BlocConsumer<SplashBloc,SplashState>(
            
            listener: (context,state) async{
               if(state is SplashCompleteState){
                 bool? isLogin = await SharedPreferenceService.checkUserLogin("IsLogin");
                if(isLogin==false || isLogin==null ){
                  Navigator.pushReplacementNamed(context, "/login-screen");
                }else{
                  Navigator.pushReplacementNamed(context, "/layout-screen");
                }
              }
            }
            ,builder: (context,state){
              if(state is SplashStartState){
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          LITE_RED_COLOR,
                          LITE_YELLOW_COLOR                        ],
                        begin:Alignment.topRight,
                        end: Alignment.bottomLeft
                    ),
                  ),
                  child: Image.asset("assets/images/sp1.gif"),
                );
              }else{
                return Container();
              }
            }
        ),
      ),
    );
  }
}

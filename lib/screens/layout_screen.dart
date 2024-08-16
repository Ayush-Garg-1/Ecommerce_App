import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/explore_screen.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/filterBloc/filter_bloc.dart';
import '../bloc/filterBloc/filter_event.dart';
import '../utils/appWidgetFunction/drawer.dart';
import 'filters_screen.dart';

class LayoutScreen extends StatefulWidget {
  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    List<String> titles = ["Ecommerce App","Explore Now","My Cart","Filters","User Profile"];
    List<Widget> screens = [HomeScreen(),
      ExploreScreen(),
      CartScreen(),
      BlocProvider(
          create: (_)=>FilterBloc()..add(FetchAllProductEvent()),
          child:FilterScreen()
      ),
      ProfileScreen()
    ];
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              size: 40,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: Text(
         titles.elementAt(selectedIndex),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      drawer: CustomDrawer(),
      body: screens.elementAt(selectedIndex),
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,

        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.red,
        color: Colors.orange,
        items: [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.explore_sharp,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.filter_list,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {},
      //     foregroundColor: Colors.white,
      //     backgroundColor: Colors.orange,
      //     hoverColor: Colors.red,
      //     child: Icon(
      //       Icons.arrow_upward,
      //       color: Colors.white,
      //       size: 30,
      //     )),
    );
  }
}

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
import '../utils/themes/colors.dart';
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
    return
      Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 40,
                color:Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          title: Text(
            titles.elementAt(selectedIndex),
            style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        drawer: CustomDrawer(),
        body: screens.elementAt(selectedIndex),
        bottomNavigationBar: CurvedNavigationBar(
          height: 70,
          backgroundColor:TRANSPARENT_COLOR,
          buttonBackgroundColor: RED_COLOR,
          color: Theme.of(context).primaryColor,
          items: [
            Icon(
              Icons.home,
              size: 30,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            Icon(
              Icons.explore_sharp,
              size: 30,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            Icon(
              Icons.shopping_cart,
              size: 30,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            Icon(
              Icons.filter_list,
              size: 30,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ],
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      );
  }
}

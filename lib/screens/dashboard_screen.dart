import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: Text("Ayush"),
          ),
          Container(
            child: Text("Garg"),
          )
        ],
      ),
    );
  }
}

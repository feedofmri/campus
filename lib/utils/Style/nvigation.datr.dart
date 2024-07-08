import 'package:campus/utils/Style/welcome.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:campus/utils/Style/document.dart';
import 'package:campus/utils/Style/institutions.dart';
import 'package:campus/utils/Style/massage.dart';
import 'package:campus/utils/Style/Profile.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int mindex = 0;
  List<Widget> widgetList = [
    Welcomepage(),
    Document(),
    Institutions(),
    Massages(),
    Profile()
  ];
  List<Color> colorList = [
    Colors.deepPurple,
    Colors.pink,
    Color(0xFF0097A7),
    Colors.amber,
    Colors.blue
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetList[mindex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 5,
              )
            ]),
        child: CurvedNavigationBar(
          index: mindex,
          color: Colors.white38,
          buttonBackgroundColor: Colors.white,
          backgroundColor: colorList[mindex],
          animationDuration: Duration(milliseconds: 300),
          items: [
            Icon(Icons.home,
                size: 30,
                color: mindex == 0 ? Color(0xFF21a663) : Colors.black),
            Icon(Icons.newspaper,
                size: 30,
                color: mindex == 1 ? Color(0xFF21a663) : Colors.black),
            Icon(Icons.school,
                size: 30,
                color: mindex == 2 ? Color(0xFF21a663) : Colors.black),
            Icon(Icons.chat,
                size: 30,
                color: mindex == 3 ? Color(0xFF21a663) : Colors.black),
            Icon(Icons.people_alt_sharp,
                size: 30,
                color: mindex == 4 ? Color(0xFF21a663) : Colors.black),
          ],
          onTap: (index) {
            setState(() {
              mindex = index;
            });
          },
        ),
      ),
    );
  }
}

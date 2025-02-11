import 'package:blood_donation_application/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:blood_donation_application/screens/schedule_list.dart';
import 'package:blood_donation_application/screens/login.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _pageIndex = 0;
  final List<Widget> _page =[ScheduleListScreen(), login()];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _page[_pageIndex],
      bottomNavigationBar:
        CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          items: <Widget>[
            Icon(Icons.list, size: 30),
            Icon(Icons.schedule_outlined, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.redAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
          letIndexChange: (index) => true,
        ),
    );

  }
}
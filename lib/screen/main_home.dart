// import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:meomeo/helpers/color.dart';
import 'package:meomeo/screen/account/account.dart';
import 'package:meomeo/screen/home/home.dart';
import 'package:meomeo/screen/map/map.dart';
import 'package:flutter/material.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int currentPage = 0;
  Widget _widget = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.white,child: _widget),
      // bottomNavigationBar: FancyBottomNavigation(
      //   inactiveIconColor: Colors.grey,
      //   initialSelection: currentPage,
      //   circleColor: colorLogo,
      //   activeIconColor: Colors.white,
      //   tabs: [
      //     TabData(iconData: Icons.home, title: ""),
      //     TabData(iconData: Icons.search, title: ""),
      //     TabData(iconData: Icons.account_circle_outlined, title: "")
      //   ],
      //   onTabChangedListener: (position) {
      //     setState(() {
      //       currentPage = position;
      //       setScreen(position);
      //     });
      //   },
      // ),
    );
  }

  setScreen(int position){
    switch(position) {
      case 0: _widget = HomeScreen();break;
      case 1: _widget = MapScreen();break;
      case 2: _widget = AccountScreen();break;
      default:_widget = HomeScreen();break;
    }

  }
}

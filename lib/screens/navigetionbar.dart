import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home/home.dart';
import 'home/notification.dart';
import 'home/profile.dart';
import '../shared/my_flutter_app_icons.dart'as myIcons;

class NavigationTabBar extends StatefulWidget {
  @override
  _NavigationTabBarState createState() => _NavigationTabBarState();
}

class _NavigationTabBarState extends State<NavigationTabBar> {

  int currentIndex=0;
  List<Widget> myPage= <Widget>[
      Home(),
      Profile(),
     AnimatedListSample(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: FancyBottomNavigation(
        barBackgroundColor:Colors.orangeAccent[400],
        circleColor: Colors.white,
        activeIconColor: Colors.black,
        inactiveIconColor: Colors.black,
        initialSelection: currentIndex,

        tabs: [
          TabData(title: 'Study',
           iconData:myIcons.MyFlutterApp.sdy ,
          ),
          TabData(iconData:myIcons.MyFlutterApp.student,
              title: 'Profile',
            onclick:(){
            Navigator.pop(context);
            }
          ),
          TabData(iconData:myIcons.MyFlutterApp.setting, title: 'Setting',
              onclick:(){
                Navigator.pop(context);
              })
        ],

        onTabChangedListener: (position) {
          setState(() {
            currentIndex = position;
          });
        },
      ),
      body:
//      myPage.elementAt(currentIndex),
      CupertinoTabView(
        builder: (context){
          return CupertinoPageScaffold(
            child: myPage[currentIndex],
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/database/constants.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/view_models/home_view_model.dart';
import 'package:inses_app/views/admin_home.dart';
import 'package:inses_app/views/home.dart';
import 'package:inses_app/views/profile.dart';
import 'package:inses_app/views/bookings.dart';
import 'package:line_icons/line_icons.dart';

class HomeMain extends StatefulWidget {

  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: _buildView(),
        onWillPop: ()async{
          App().closeApp();
          return true;
        }
    );
  }

  Widget _buildView(){

    final List<Widget> _children = HomeViewModel.loginStatus==AppConstants.LOGGED_IN_ADMIN
        ?[
        AdminHome(),
        Bookings(),
        Profile()
    ]
        :[
      Home(),
      Bookings(),
      Profile()
    ];

    return Scaffold(
      body: _children[_currentIndex], //
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: onTabTapped,
        elevation: 16,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.PRIMARY_COLOR,
        unselectedItemColor: AppColors.WHITE_3,
        iconSize: 22,
        selectedLabelStyle: TextStyle(
          fontSize: AppDimen.TEXT_SMALLEST,
          fontFamily: AppFont.FONT,
          fontWeight: FontWeight.w500
        ),
        unselectedLabelStyle: TextStyle(
            fontSize: AppDimen.TEXT_SMALLEST,
            fontFamily: AppFont.FONT,
            fontWeight: FontWeight.w500
        ),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(LineIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_sharp),
            label: 'My Bookings',
          ),
          BottomNavigationBarItem(
              icon: Icon(LineIcons.user),
              label: 'Profile'
          ),
        ],
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

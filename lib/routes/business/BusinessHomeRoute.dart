import 'package:flutter/material.dart';
import 'package:jepret/constants/Assets.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/pages/business/BusinessDashboardPage.dart';
import 'package:jepret/pages/business/BusinessProfilePage.dart';
import 'package:jepret/pages/business/ApplyInsurancePage.dart';
import 'package:jepret/routes/individual/IndividualHomeRoute.dart';
import 'package:jepret/routes/SettingsRoute.dart';
import 'package:jepret/app.dart';

class BusinessHomeRoute extends StatefulWidget {
  BusinessHomeRouteState createState() => BusinessHomeRouteState();
}

class BusinessHomeRouteState extends State<BusinessHomeRoute> {
  int _currentIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _renderAppBar(_currentIndex),
      body: _renderBody(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex, // this will be set when a new tab is tapped
      onTap: _onTabTapped,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: new Icon(Icons.pie_chart_outlined),
          title: new Text('Dashboard'/*, style: TextStyle(fontWeight: FontWeight.bold)*/),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.description),
            title: Text('Penjaminan'/*, style: TextStyle(fontWeight: FontWeight.bold)*/)
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profil'/*, style: TextStyle(fontWeight: FontWeight.bold)*/)
        )
      ],
    ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed) {
      JepretAppState state = JepretApp.of(context);
      state.refreshBusinessProfile();
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _renderAppBar(int index) {
    switch(index) {
      case 0:
        return AppBar(
          backgroundColor: Colors.white,
          title: _renderLogoTitle(),
          elevation: 1,
          automaticallyImplyLeading: false,
          centerTitle: false,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: IconButton(
                  onPressed: () {
                    _switchToIndividualProfile();
                  },
                  icon: Icon(Icons.swap_horiz, color: JepretColor.PRIMARY_DARKER)
              )
            )
          ],
        );
      case 1:
        return AppBar(
            centerTitle: false,
            backgroundColor: Colors.white,
            elevation: 1,
            automaticallyImplyLeading: false,
            title: HeadingText(text: "Penjaminan")
        );
      case 2:
        return AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: HeadingText(text: "Profil"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              color: JepretColor.PRIMARY_DARKER,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => SettingsRoute())
                );
              },
            )
          ]
        );
      default:
        return AppBar(
          backgroundColor: Colors.white,
          title: _renderLogoTitle(),
          elevation: 0,
          automaticallyImplyLeading: false,
        );
    }
  }

  Widget _renderBody(int index) {
    switch(index) {
      case 0:
        return BusinessDashboardPage();
      case 1:
        return ApplyInsurancePage();
      case 2:
        return BusinessProfilePage();
    }
  }

  Widget _renderLogoTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image(image: AssetImage(Assets.LOGO), height: 24),
        Container(width: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: "NunitoSans",
              color: JepretColor.PRIMARY_DARKER,
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
            children: <TextSpan>[
              TextSpan(text: "Jepret "),
              TextSpan(
                text: "UMKM",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal
                )
              )
            ]
          ),
        )
      ],
    );
  }

  void _switchToIndividualProfile() {
    Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) => IndividualHomeRoute(),
          transitionsBuilder: (context, anim1, anim2, child) => FadeTransition(opacity: anim1, child: child),
          transitionDuration: Duration(milliseconds: 250),
        )
    );
  }
}
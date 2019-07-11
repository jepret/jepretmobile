import 'package:flutter/material.dart';
import 'package:jepret/constants/Assets.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/pages/home/HomePage.dart';
import 'package:jepret/pages/home/NearbyPage.dart';

class HomeRoute extends StatefulWidget {
  HomeRouteState createState() => HomeRouteState();
}

class HomeRouteState extends State<HomeRoute> {
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
          icon: new Icon(Icons.home),
          title: new Text('Beranda'/*, style: TextStyle(fontWeight: FontWeight.bold)*/),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            title: Text('Sekitar'/*, style: TextStyle(fontWeight: FontWeight.bold)*/)
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profil'/*, style: TextStyle(fontWeight: FontWeight.bold)*/)
        )
      ],
    ),
    );
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
        );
      case 1:
        return null;
      case 2:
        return null;
      default:
        return AppBar(
          backgroundColor: Colors.white,
          title: _renderLogoTitle(),
          elevation: 0,
        );
    }
  }

  Widget _renderBody(int index) {
    switch(index) {
      case 0:
        return HomePage();
      case 1:
        return NearbyPage();
      case 2:
        return null;
    }
  }

  Widget _renderLogoTitle() {
    return Row(
      children: <Widget>[
        Image(image: AssetImage(Assets.LOGO), height: 24),
        Container(width: 8),
        HeadingText(text: "Jepret")
      ],
    );
  }
}
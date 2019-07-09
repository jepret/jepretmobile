import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/pages/home/tabs/profile/IndividualTab.dart';

class ProfilePage extends StatefulWidget {
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _renderProfileHeading(),
              _renderTabBar(),
              Expanded(
                  child: _renderTabBody()
              )
            ],
          )
        )
    );
  }

  Widget _renderProfileHeading() {
    return Container(
      color: JepretColor.PRIMARY_DARKER,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Agung Boba",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700
              ),
            ),
            Text(
              "agungboba@gmail.com",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w200
              ),
            ),
          ],
        )
      )
    );
  }

  Widget _renderTabBar() {
    return Container(
      color: Color.fromARGB(255, 240, 240, 240),
      child: TabBar(
        indicatorColor: JepretColor.PRIMARY_DARKER,
        tabs: [
          Tab(text: "Perorangan"),
          Tab(text: "Usaha")
        ],
      )
    );
  }

  Widget _renderTabBody() {
    return TabBarView(
      children: [
        IndividualTab(),
        Icon(Icons.directions_transit),
      ],
    );
  }
}
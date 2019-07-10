import 'package:flutter/material.dart';
import 'package:jepret/constants/Assets.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/pages/home/HomePage.dart';
import 'package:jepret/pages/home/ProfilePage.dart';

class BusinessDashboardRoute extends StatefulWidget {
  BusinessDashboardRouteState createState() => BusinessDashboardRouteState();
}

class BusinessDashboardRouteState extends State<BusinessDashboardRoute> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: JepretColor.PRIMARY_DARKER),
          onPressed: () {
            Navigator.of(context).pop();
          }
        ),
        title: Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _renderIncentiveHeading(),
          ],
        )
      )
    );
  }

  Widget _renderIncentiveHeading() {
    return Container(
        color: JepretColor.PRIMARY_DARKER,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Colors.black12,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Row(
                  children: <Widget>[
                    Text("Pendapatan Anda", style: TextStyle(color: Colors.white, fontSize: 16)),
                    Spacer(),
                    Icon(Icons.arrow_forward, color: Colors.white)
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    HeadingText(text: "Rp 167.252,-", color: Colors.white),
                    Spacer(),
                    Text("250 ulasan", style: TextStyle(color: Colors.white))
                  ],
                )
            ),
            Divider(height: 1, color: Colors.white70),
            Row(
              children: <Widget>[
                Expanded(
                    child: FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.attach_money),
                      label: Text("Tarik"),
                      textColor: Colors.white,
                    )
                )
              ],
            ),
          ],
        )
    );
  }
}
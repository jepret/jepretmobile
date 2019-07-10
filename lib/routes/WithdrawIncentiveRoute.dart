import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/partials/BusinessDashboardVisitorLineChart.dart';
import 'package:jepret/partials/BusinessDashboardReviewBarChart.dart';
import 'package:intl/intl.dart';

class WithdrawIncentiveRoute extends StatefulWidget {
  WithdrawIncentiveRouteState createState() => WithdrawIncentiveRouteState();
}

class WithdrawIncentiveRouteState extends State<WithdrawIncentiveRoute> {
  int currentBalance = 5668456;
  int currentReviews = 256;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: JepretColor.PRIMARY_DARKER),
          onPressed: () {
            Navigator.of(context).pop();
          }
        ),
        title: Text("Tarik Pendapatan", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _renderIncentiveHeading(),
            Divider(height: 1),
            _renderInputTextField(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text("Metode penarikan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
            ),
            Divider(height:1),
            Container(
              color: Colors.white,
              child:  Column(
                children: <Widget>[
                  _listMenuItem("Transfer Bank", Icon(Icons.sync), onTap: () {}),
                  Divider(height: 1),
                  _listMenuItem(
                      "GO-PAY",
                      Image(
                          width: 32,
                          image: NetworkImage("https://pbs.twimg.com/profile_images/1054316288019845121/OaUESnip_400x400.jpg")
                      ),
                      onTap: () {}
                  ),
                  Divider(height: 1),
                  _listMenuItem(
                      "OVO",
                      Image(
                          width: 32,
                          image: NetworkImage("https://images-loyalty.ovo.id/public/merchant/01/00/1.png?ver=1545580203")
                      ),
                      onTap: () {}
                  ),
                ],
              )
            ),
            Divider(height: 1),
          ],
        )
      )
    );
  }

  Widget _renderIncentiveHeading() {
    return Container(
        color: Color.fromARGB(255, 245, 245, 245),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Total Pendapatan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              Container(height: 8),
              Text(
                "Rp112.001",
                style: TextStyle(
                  color: JepretColor.PRIMARY_DARKER,
                  fontWeight: FontWeight.bold,
                  fontSize: 32
                )
              )
            ],
          ),
        )
    );
  }

  Widget _renderInputTextField() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: 16),
          Text("Jumlah yang ingin ditarik", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(height: 16),
          JepretTextField(
            icon: Container(
              width: 56,
              child: Center(
                  child: Text("Rp", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
              )
            ),
            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
          )
        ],
      ),
    );
  }

  Widget _listMenuItem(String title, Widget icon, {VoidCallback onTap, Color color}) {
    return ListTile(
      leading: icon,
      title: Text(title, style: TextStyle(color: color)),
      onTap: onTap,
    );
  }
}
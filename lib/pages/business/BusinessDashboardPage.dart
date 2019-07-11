import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/partials/business/BusinessDashboardVisitorLineChart.dart';
import 'package:jepret/partials/business/BusinessDashboardReviewBarChart.dart';
import 'package:jepret/routes/business/WithdrawIncentiveRoute.dart';
import 'package:jepret/app.dart';
import 'package:intl/intl.dart';
import 'package:after_layout/after_layout.dart';

class BusinessDashboardPage extends StatefulWidget {
  BusinessDashboardPageState createState() => BusinessDashboardPageState();
}

class BusinessDashboardPageState extends State<BusinessDashboardPage> with AfterLayoutMixin<BusinessDashboardPage> {
  int currentBalance = 0;
  int currentReviews = 256;

  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _renderIncentiveHeading(),
            _renderSectionHeading("Statistik pengunjung", "Total pengunjung dari 10 Juli - 17 Juli: 523"),
            _renderVisitorChart(),
            Divider(),
            _renderSectionHeading("Ulasan positif", "Jumlah ulasan positif 10 Juli - 17 Juli: 12"),
            _renderPositiveReviewsChart(),
            Divider(),
            _renderSectionHeading("Ulasan negatif", "Jumlah ulasan negatif 10 Juli - 17 Juli: 12"),
            _renderNegativeReviewsChart(),
            Divider(),
            _renderSectionHeading("Ulasan netral", "Jumlah ulasan netral 10 Juli - 17 Juli: 12"),
            _renderNeutralReviewsChart(),
            Container(height: 48)
          ],
        )
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    JepretAppState state = JepretApp.of(context);
    setState(() {
      currentBalance = state.businessProfile.balance;
    });
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
                    HeadingText(
                        text: NumberFormat.currency(
                          locale: 'ID',
                          symbol: 'Rp'
                        ).format(currentBalance),
                        color: Colors.white
                    ),
                    Spacer(),
                    Text("${currentReviews} ulasan", style: TextStyle(color: Colors.white))
                  ],
                )
            ),
            Divider(height: 1, color: Colors.white70),
            Row(
              children: <Widget>[
                Expanded(
                    child: FlatButton.icon(
                      icon: Icon(Icons.attach_money),
                      label: Text("Tarik"),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) => WithdrawIncentiveRoute())
                        );
                      },
                    )
                )
              ],
            )
          ],
        )
    );
  }

  Widget _renderSectionHeading(String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(subtitle, style: TextStyle(fontSize: 16, color: Colors.grey))
        ],
      )
    );
  }

  Widget _renderVisitorChart() {
    return AspectRatio(
      aspectRatio: 16/8,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: BusinessDashboardVisitorLineChart(
            {
              DateTime(2019, 07, 10): 50,
              DateTime(2019, 07, 11): 65,
              DateTime(2019, 07, 12): 60,
              DateTime(2019, 07, 13): 75,
              DateTime(2019, 07, 14): 72,
              DateTime(2019, 07, 15): 90,
              DateTime(2019, 07, 16): 110,
              DateTime(2019, 07, 17): 115,
            }
        ),
      )
    );
  }

  Widget _renderPositiveReviewsChart() {
    return AspectRatio(
      aspectRatio: 16/8,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: BusinessDashboardReviewBarChart(
            {
              DateTime(2019, 07, 10): 50,
              DateTime(2019, 07, 11): 65,
              DateTime(2019, 07, 12): 60,
              DateTime(2019, 07, 13): 75,
              DateTime(2019, 07, 14): 72,
              DateTime(2019, 07, 15): 90,
              DateTime(2019, 07, 16): 110,
              DateTime(2019, 07, 17): 115,
            }
        ),
      )
    );
  }

  Widget _renderNegativeReviewsChart() {
    return AspectRatio(
        aspectRatio: 16/8,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: BusinessDashboardReviewBarChart(
              {
                DateTime(2019, 07, 10): 50,
                DateTime(2019, 07, 11): 65,
                DateTime(2019, 07, 12): 60,
                DateTime(2019, 07, 13): 75,
                DateTime(2019, 07, 14): 72,
                DateTime(2019, 07, 15): 90,
                DateTime(2019, 07, 16): 110,
                DateTime(2019, 07, 17): 115,
              }
          ),
        )
    );
  }

  Widget _renderNeutralReviewsChart() {
    return AspectRatio(
        aspectRatio: 16/8,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: BusinessDashboardReviewBarChart(
              {
                DateTime(2019, 07, 10): 50,
                DateTime(2019, 07, 11): 65,
                DateTime(2019, 07, 12): 60,
                DateTime(2019, 07, 13): 75,
                DateTime(2019, 07, 14): 72,
                DateTime(2019, 07, 15): 90,
                DateTime(2019, 07, 16): 110,
                DateTime(2019, 07, 17): 115,
              }
          ),
        )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:jepret/constants/JepretColor.dart';

class BusinessDashboardReviewBarChart extends StatelessWidget {
  final bool animate;
  final Map<DateTime, double> data;
  List<charts.Series<LinearRecord, DateTime>> seriesList;

  BusinessDashboardReviewBarChart(this.data, {this.animate: false}) {
    List<LinearRecord> recordList = [];
    data.forEach((DateTime time, double value) {
      recordList.add(LinearRecord(time, value));
    });

    this.seriesList = [
      new charts.Series<LinearRecord, DateTime>(
        id: 'Visitors',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(JepretColor.PRIMARY),
        domainFn: (LinearRecord visitor, _) => visitor.time,
        measureFn: (LinearRecord visitor, _) => visitor.data,
        data: recordList,
      )
    ];
  }

  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.BarRendererConfig()
    );
  }
}

class LinearRecord {
  final DateTime time;
  final double data;

  LinearRecord(this.time, this.data);
}
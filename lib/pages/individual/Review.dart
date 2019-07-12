import 'package:flutter/material.dart';
import 'package:jepret/components/OutlinedPrimaryButton.dart';
import 'package:jepret/components/AppBarWithImage.dart';
import 'package:jepret/pages/individual/ReviewSteps.dart';

class Review extends StatefulWidget {
  Review() : super();

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.width * 0.50,
                  maxWidth: MediaQuery.of(context).size.width * 1.00,
                ),
                child: AppBarWithImage(),
              ),
              Container(
//              constraints: BoxConstraints(
//                maxHeight: MediaQuery.of(context).size.width * 1.00,
//                maxWidth: MediaQuery.of(context).size.width * 1.00,
//              ),
                child: Column(
                  children: <Widget>[
                    ReviewSteps(),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}


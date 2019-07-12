import 'package:flutter/material.dart';
import 'package:jepret/model/Partner.dart';
import 'package:jepret/components/AppBarWithImage.dart';
import 'package:jepret/pages/individual/ReviewSteps.dart';

class Review extends StatefulWidget {
  Partner partner;
  Review(this.partner);

  @override
  _ReviewState createState() => _ReviewState(partner);
}

class _ReviewState extends State<Review> {
  Partner partner;
  _ReviewState(this.partner);

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
              AspectRatio(
                aspectRatio: 16/10,
                child: AppBarWithImage(partner),
              ),
              Container(
//              constraints: BoxConstraints(
//                maxHeight: MediaQuery.of(context).size.width * 1.00,
//                maxWidth: MediaQuery.of(context).size.width * 1.00,
//              ),
                child: Column(
                  children: <Widget>[
                    ReviewSteps(partner),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}


import 'package:flutter/material.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/model/Partner.dart';

class AppBarWithImage extends StatefulWidget {
  Partner partner;
  AppBarWithImage(this.partner) : super();

  @override
  _AppBarWithImageState createState() => _AppBarWithImageState(partner);
}

class _AppBarWithImageState extends State<AppBarWithImage> {
  Partner partner;

  _AppBarWithImageState(this.partner);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        elevation: 8,
        shadowColor: Colors.black87,
        color: Colors.white,
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(this.partner.imageUrl),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0, 1],
                          colors: [
                            Colors.black54,
                            Colors.transparent
                          ]
                      )
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 15.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Container(height: 40),
                            HeadingText(text: this.partner.name, color: Colors.white),
                            Text(this.partner.location.streetAddress, style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
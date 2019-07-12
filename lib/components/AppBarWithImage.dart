import 'package:flutter/material.dart';
import 'package:jepret/components/HeadingText.dart';

class AppBarWithImage extends StatefulWidget {
  AppBarWithImage() : super();

  @override
  _AppBarWithImageState createState() => _AppBarWithImageState();
}

class _AppBarWithImageState extends State<AppBarWithImage> {

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
                image: NetworkImage("https://img.sndimg.com/food/image/upload/w_560,h_315,c_fill,fl_progressive,q_80/v1/img/recipes/53/74/76/83kDuWs7QsCf4oZ0rhFs_0S9A7513.jpg"),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.arrow_back, color: Colors.white),
                          const SizedBox(height: 40.00),
                          HeadingText(text: "Christzen's Steakhouse", color: Colors.white),
                          Text("Jl. Mega Kuningan Barat No. 3", style: TextStyle(color: Colors.white)),
                        ],
                      ),
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
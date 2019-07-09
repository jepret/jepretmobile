import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';

class HomeShowcaseCard extends StatelessWidget {
  String title;
  String subtitle;
  ImageProvider<dynamic> backgroundImage;
  VoidCallback onPressed;
  double width;

  HomeShowcaseCard({@required this.title, @required this.subtitle, this.onPressed, this.width: 200, this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 24),
      child: GestureDetector(
        onTap: onPressed,
        child: AspectRatio(
          aspectRatio: 16/8,
          child: Material(
              elevation: 8,
              shadowColor: Colors.black87,
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: backgroundImage
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(1.5, 1.5),
                                            blurRadius: 1.0,
                                            color: Colors.black54,
                                          ),
                                        ]
                                    )
                                ),
                                Text(
                                    subtitle,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(1.5, 1.5),
                                            blurRadius: 1.0,
                                            color: Colors.black54,
                                          ),
                                        ]
                                    )
                                )
                              ],
                            ),
                          )
                      ),
                    ],
                  )
              )
          ),
        )
      )
    );
  }
}
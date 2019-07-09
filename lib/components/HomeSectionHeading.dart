import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';

class HomeSectionHeading extends StatelessWidget {
  String title;
  String subtitle;
  Widget icon;

  HomeSectionHeading({@required this.title, this.subtitle, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Container(
            child: this.icon,
          ),
          Container(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    )
                ),
                Container(height: 2),
                Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54
                    )
                ),
              ],
            )
          )
        ],
      )
    );
  }
}
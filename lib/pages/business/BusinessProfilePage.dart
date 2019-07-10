import 'package:flutter/material.dart';
import 'package:jepret/components/CompletionProgressBar.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/pages/business/BusinessDashboardPage.dart';

class BusinessProfilePage extends StatefulWidget {
  BusinessProfilePageState createState() => BusinessProfilePageState();
}

class BusinessProfilePageState extends State<BusinessProfilePage> {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Container(height: 16),
                _renderInformationStatusHeader(),
                Container(height: 32),
              ]
            )
        )
    );
  }

  Widget _renderInformationStatusHeader() {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 36, 0, 0),
          child: Material(
            borderRadius: BorderRadius.circular(4),
            color: JepretColor.PRIMARY_DARKER_10,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 52, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  HeadingText(text: "Toko Sinar", color: Colors.black),
                  Text(
                      "Kelengkapan data: 60%",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400
                      )
                  ),
                  Container(height: 16),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: CompletionProgressBar(
                        totalSteps: 5,
                        completedSteps: 3,
                      )
                  ),
                  Container(height: 16),
                  Text(
                    "Lengkapi data untuk dapat mencairkan insentif dan mengajukan peminjaman modal",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black54
                    ),
                  ),
                  Container(height: 16),
                  Divider(height: 1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Lengkapi data",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: JepretColor.PRIMARY_DARKER
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color.fromARGB(255, 210, 210, 210), width: 3)
          ),
          child: CircleAvatar(
            radius: 36,
            backgroundImage: NetworkImage('http://soulofjakarta.com/images-artikel/besar/Tips-Merawat-Kulit-yang-Terkena-Paparan-Sinar-Matahari.jpg'),
          ),
        )
      ],
    );
  }
  
  Widget _renderCardMenu(IconData icon, String text, VoidCallback onPressed) {
    return MaterialButton(
      elevation: 1,
      color: Colors.white,
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: Colors.grey,),
            Container(width: 24),
            Text(text, style: TextStyle(fontSize: 16))
          ],
        )
      ),
    );
  }
}
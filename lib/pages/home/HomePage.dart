import 'package:flutter/material.dart';
import 'package:jepret/constants/Assets.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/components/HomeShowcaseCard.dart';
import 'package:jepret/components/HomeSectionHeading.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _renderIncentiveHeading(),
          _renderQuestSection(),
          Divider(height: 1),
          _renderNearbySection()
        ],
      )
    );
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
                HeadingText(text: "Rp 205.431,-", color: Colors.white),
                Spacer(),
                Text("50 kunjungan", style: TextStyle(color: Colors.white))
              ],
            )
          ),
          Divider(height: 1, color: Colors.white70),
          Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.attach_money),
                    label: Text("Tarik"),
                    textColor: Colors.white,
                  )
              ),
              Container(height: 48, child: VerticalDivider(color: Colors.white70)),
              Expanded(
                  child: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.find_in_page),
                    label: Text("Buat Ulasan"),
                    textColor: Colors.white,
                  )
              )
            ],
          ),
        ],
      )
    );
  }

  Widget _renderQuestSection() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(height: 12),
          HomeSectionHeading(
              title: "Petualangan kamu",
              subtitle: "Kunjungi tempat-tempat ini dan dapatkan poin tambahan!",
              icon: Image(height: 48, image: AssetImage(Assets.ICON_QUEST))
          ),
          Container(height: 8),
          AspectRatio(
            aspectRatio: 16/7,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(width: 8),
                HomeShowcaseCard(
                  title: "Onel's Kitchen",
                  subtitle: "Dapatkan 40 poin",
                  backgroundImage: NetworkImage("https://img.sndimg.com/food/image/upload/w_560,h_315,c_fill,fl_progressive,q_80/v1/img/recipes/53/74/76/83kDuWs7QsCf4oZ0rhFs_0S9A7513.jpg"),
                  onPressed: () {},
                ),
                HomeShowcaseCard(
                  title: "Gabu's Weebs Store",
                  subtitle: "Dapatkan 35 poin",
                  backgroundImage: NetworkImage("http://i.imgur.com/juY3Z2z.jpg"),
                  onPressed: () {},
                ),
                Container(width: 8)
              ],
            ),
          ),
          Container(height: 12)
        ],
      )
    );
  }

  Widget _renderNearbySection() {
    return Container(
        child: Column(
          children: <Widget>[
            Container(height: 12),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Text("Mitra Terdekat", style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(width: 8),
                  Icon(Icons.arrow_forward, size: 18,)
                ],
              ),
            ),
            AspectRatio(
              aspectRatio: 16/7,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(width: 8),
                  HomeShowcaseCard(
                    title: "Feby's Breakfast",
                    subtitle: "700m",
                    backgroundImage: NetworkImage("http://www.thebedfordgc.com/wp-content/uploads/2019/03/burger.jpg"),
                    onPressed: () {},
                  ),
                  HomeShowcaseCard(
                    title: "Warung Ko Christzen",
                    subtitle: "1.1km",
                    backgroundImage: NetworkImage("http://marketeers.com/wp-content/uploads/2018/11/warung_xl-a.jpg"),
                    onPressed: () {},
                  ),
                  Container(width: 8)
                ],
              ),
            ),
            Container(height: 12)
          ],
        )
    );
  }
}
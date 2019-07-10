import 'package:flutter/material.dart';
import 'package:jepret/constants/Assets.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/components/HomeShowcaseCard.dart';
import 'package:jepret/components/HomeSectionHeading.dart';
import 'package:jepret/model/Offering.dart';
import 'package:jepret/model/Partner.dart';
import 'package:jepret/model/Location.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Offering> questItems;
  List<Partner> nearestPartnerItems;
  Location currentLocation;
  double currentBalance = 256541;
  int currentVisits = 34;

  @override
  void initState() {
    super.initState();
    this.setState(() {
      this.questItems = [
        Offering(
            monetaryOffering: 5343,
            partner: Partner(
              partnerId: "abxbdc",
              name: "Onel's Kitchen",
              imageUrl: "https://img.sndimg.com/food/image/upload/w_560,h_315,c_fill,fl_progressive,q_80/v1/img/recipes/53/74/76/83kDuWs7QsCf4oZ0rhFs_0S9A7513.jpg",
            )
        ),
        Offering(
            monetaryOffering: 2456,
            partner: Partner(
              partnerId: "abxbdc2",
              name: "Gabu's Weebs Store",
              imageUrl: "http://i.imgur.com/juY3Z2z.jpg",
            )
        ),
        Offering(
            monetaryOffering: 1425,
            partner: Partner(
              partnerId: "abxbdc3",
              name: "Warmindo Putra Sunda",
              imageUrl: "https://2.bp.blogspot.com/-kYVFJrav8As/WrFs74W9EDI/AAAAAAAAArc/g4M-wQe7bgcD19JyQ-9EHW7gAiku4KeEgCLcBGAs/s1600/burjo%2Bbisnis%2Bmodal%2Bkecil%2Bkeuntungan%2Bbesar.jpg",
            )
        )
      ];

      this.nearestPartnerItems = [
        Partner(
            partnerId: "166gd6",
            name: "Feby's Breakfast Joint",
            imageUrl: "http://www.thebedfordgc.com/wp-content/uploads/2019/03/burger.jpg"
        ),
        Partner(
            partnerId: "556s556d",
            name: "Warung Ko Christzen",
            imageUrl: "http://marketeers.com/wp-content/uploads/2018/11/warung_xl-a.jpg"
        )
      ];

      this.currentLocation = Location(
        streetAddress: "Sopo Del Tower B Lt 8",
        municipality: "Jakarta Selatan",
        province: "DKI Jakarta",
        lat: 0,
        lon: 0
      );
    });
  }

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
                HeadingText(
                    text: NumberFormat.currency(
                      locale: "ID",
                      symbol: "Rp"
                    ).format(currentBalance),
                color: Colors.white),
                Spacer(),
                Text("${currentVisits} kunjungan", style: TextStyle(color: Colors.white))
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: questItems.length,
              itemBuilder: (BuildContext context, int index) {
                final Offering _offering = questItems[index];
                final double paddingLeft = (index == 0) ? 8 : 0;
                final double paddingRight = (index == questItems.length-1) ? 8 : 0;

                return Padding(
                  padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingRight, 0),
                  child: HomeShowcaseCard(
                    title: _offering.partner.name,
                    subtitle: "Dapatkan Rp${_offering.monetaryOffering.round()},-",
                    backgroundImage: NetworkImage(_offering.partner.imageUrl),
                    onPressed: () {},
                  )
                );
              },
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: nearestPartnerItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final Partner _partner = nearestPartnerItems[index];
                  final double paddingLeft = (index == 0) ? 8 : 0;
                  final double paddingRight = (index == nearestPartnerItems.length-1) ? 8 : 0;

                  return Padding(
                      padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingRight, 0),
                      child: HomeShowcaseCard(
                        title: _partner.name,
                        subtitle: "456m", // TODO calculate
                        backgroundImage: NetworkImage(_partner.imageUrl),
                        onPressed: () {},
                      )
                  );
                },
              ),
            ),
            Container(height: 12)
          ],
        )
    );
  }
}
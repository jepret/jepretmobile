import 'package:flutter/material.dart';
import 'package:jepret/pages/individual/Review.dart';
import 'dart:convert';

class NearbyResultPage extends StatefulWidget {
  List<dynamic> items;
  NearbyResultPage({@required this.items}) : super();

  @override
  _NearbyResultPageState createState() => _NearbyResultPageState(items: this.items);
}

class _NearbyResultPageState extends State<NearbyResultPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<dynamic> items;
  _NearbyResultPageState({@required this.items});

  openPersistentBottomController(BuildContext context){
    int count = items.length;
    _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return Container(
          padding: EdgeInsets.all(30.0),
          color: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(Icons.keyboard_arrow_up, color: Colors.black54),
              Text("Tampilkan $count mitra sekitar", style: TextStyle(fontSize: 20)),
            ],
          )
      );
    })
        .closed.whenComplete(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> listTiles = items.map<Widget>((dynamic item) => buildListTile(context, item));
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: listTiles.toList(),
      ),
    );
  }
}

Widget buildListTile(BuildContext context, dynamic item) {
//  Map umkmDetail = jsonDecode(item);
  var name = item['name'];
//  var distance = umkmDetail['distance'];
  var distance = '1';
  var image = item['photo'];
  var rewardLevel = item['reward_level'];

  return MergeSemantics(
    child: ListTile(
      isThreeLine: false,
      dense: false,
      leading: ExcludeSemantics(child: Image(height: 40, width: 40, image: NetworkImage(image))),
      title: Text('$name', style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.location_on, size: 18.0),
              const SizedBox(width: 2.0),
              Text('$distance km'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _renderRewardLevelStars(rewardLevel),
          )
        ],
      ),
      trailing: Icon(Icons.arrow_forward, color: Theme.of(context).disabledColor),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Review())
        );
      },
    ),
  );
}

List<Widget> _renderRewardLevelStars(int rewardLevel) {
  List<Widget> list = new List();
  for (var i = 0; i < rewardLevel; i++) {
    list.add(Text("\$"));
  }
  for (var i = 0; i < 5-rewardLevel; i++) {
    list.add(const SizedBox(width: 9.0),);
  }
  list.add(const SizedBox(width: 120.0),);
  return list;
}
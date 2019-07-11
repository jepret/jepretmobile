import 'package:flutter/material.dart';
import 'package:jepret/app.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/components/PrimaryButton.dart';
import 'package:jepret/components/LoadingDialog.dart';
import 'package:jepret/service/UserService.dart';
import 'package:jepret/model/Transaction.dart';
import 'package:after_layout/after_layout.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:intl/intl.dart';

class RedeemIncentiveRoute extends StatefulWidget {
  String merchantId;
  RedeemIncentiveRoute(this.merchantId);

  RedeemIncentiveRouteState createState() => RedeemIncentiveRouteState(merchantId);
}

class RedeemIncentiveRouteState extends State<RedeemIncentiveRoute> {
  String merchantId;
  FocusNode _focus = FocusNode();
  TextEditingController _controller = TextEditingController();
  LoadingDialog _loadingDialog;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  RedeemIncentiveRouteState(this.merchantId);

  @override
  void initState() {
    _loadingDialog = LoadingDialog(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: JepretColor.PRIMARY_DARKER),
              onPressed: () {
                Navigator.of(context).pop();
              }
          ),
          title: Text("Belanjakan", style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: false,
        ),
        body:  FormKeyboardActions(
            keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
            actions: <KeyboardAction>[
              KeyboardAction(focusNode: _focus)
            ],
            child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _renderIncentiveHeading(),
                    Divider(height: 1),
                    _renderInputTextField(),
                    Spacer(),
                    Padding(
                        padding: EdgeInsets.all(16),
                        child: PrimaryButton(
                          text: "Belanjakan",
                          onPressed: () {
                            _attemptRedeem();
                          },
                        )
                    ),
                  ],
                )
            )
        )
    );
  }

  Widget _renderIncentiveHeading() {
    JepretAppState state = JepretApp.of(context);

    return Container(
        color: Color.fromARGB(255, 245, 245, 245),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Sisa Pendapatan",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
              Container(height: 8),
              Text(
                  NumberFormat.currency(
                      locale: "ID",
                      symbol: "Rp"
                  ).format(state.authentication.balance ?? 00),
                  style: TextStyle(
                      color: JepretColor.PRIMARY_DARKER,
                      fontWeight: FontWeight.bold,
                      fontSize: 32
                  )
              )
            ],
          ),
        )
    );
  }

  Widget _renderInputTextField() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: 16),
          Text("Jumlah yang ingin dibelanjakan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(height: 16),
          JepretTextField(
            focusNode: _focus,
            controller: _controller,
            icon: Container(
                width: 56,
                child: Center(
                    child: Text("Rp", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                )
            ),
            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
          )
        ],
      ),
    );
  }

  void _attemptRedeem() {
    try {
      if(_controller.text.length == 0) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Nominal tidak boleh kosong"),));
        return;
      }

      _loadingDialog.show();
      JepretAppState state = JepretApp.of(context);
      final int nominal = int.parse(_controller.text);

      UserService.redeemIncentive(
          state.authentication.authToken, merchantId, nominal)
          .then((Transaction transaction) {
            JepretAppState state = JepretApp.of(context);
            state.refreshAuthentication();

            _loadingDialog.hide();
            return showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Transaksi berhasil!", style: TextStyle(fontWeight: FontWeight.bold)),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Rp${nominal} berhasil diberikan kepada ${transaction.recipient.name}!"),
                      Container(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                              child: OutlineButton(
                                borderSide: BorderSide(color: JepretColor.PRIMARY_DARKER),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Tutup", style: TextStyle(color: JepretColor.PRIMARY_DARKER, fontWeight: FontWeight.bold)),
                                highlightedBorderColor: Colors.black26,
                              )
                          )
                        ],
                      ),
                    ],
                  )
                );
              },
            );
          })
          .then((_) {
            Navigator.of(context).pop();
          })
          .catchError((error) {
            _loadingDialog.hide();
            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error.toString()),));
          });
    } catch (error) {
      _loadingDialog.hide();
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error.toString()),));
    }
  }
}
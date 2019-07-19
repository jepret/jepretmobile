import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/components/OutlinedPrimaryButton.dart';
import 'package:jepret/model/Partner.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:permission_handler/permission_enums.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jepret/app.dart';
import 'package:jepret/constants/ApiEndpoints.dart';
import 'dart:io';
import 'package:jepret/components/JepretTextField.dart';
import 'package:image_picker/image_picker.dart';

import 'package:async/async.dart';

class ReviewSteps extends StatefulWidget {
  Partner partner;

  ReviewSteps(this.partner);

  @override
  _ReviewStepsState createState() => _ReviewStepsState(partner);
}

class _ReviewStepsState extends State<ReviewSteps> {
  File _image;
  TextEditingController _controller_review = new TextEditingController();
  int step;
  int lastStep;
  int rating;
  bool step1Ans;
  Partner partner;

  _ReviewStepsState(this.partner);

  @override
  void initState() {
    super.initState();

    this.setState(() {
      step = 1;
      lastStep = 0;
      rating = 0;
      _image = null;
    });
  }

  getImage() async {
    var image = await ImagePicker.pickImage();
    print('this is my image !!!!!!!!!!!!!!!!');
//    print(image);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
        child: Column(
          children: <Widget>[
            _renderStep1(context, step),
            _renderStep2(context, step),
            _renderStep3(context, step),
            _renderStep4(context, step),
            _renderBottom()
          ],
        ),
      ),
    );
  }

  Widget _renderYesNoButton() {
    return Container(
        height: 60.0,
        padding: EdgeInsets.fromLTRB(0.00, 12.00, 0.00, 0.00),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 130,
              child: OutlinedPrimaryButton(
                text: "Ya",
                onPressed: () {
                  this.setState(() {
                    step1Ans = true;
                    step = 2;
                  });
                  if (lastStep < 1) {
                    this.setState(() {
                      lastStep = 1;
                    });
                  }
                },
              ),
            ),
            Container(
              width: 130,
              child: OutlinedPrimaryButton(
                text: "Tidak",
                onPressed: () {
                  this.setState(() {
                    step1Ans = false;
                    step = 2;
                  });
                  if (lastStep < 1) {
                    this.setState(() {
                      lastStep = 1;
                    });
                  }
                },
              ),
            ),
          ],
        )
    );
  }

  Widget _renderStep1(BuildContext context, int step) {
    Widget content;

    if (step == 1) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  border: new Border.all(
                      color: JepretColor.PRIMARY_DARKER,
                      width: 3.5,
                      style: BorderStyle.solid
                  ),
                  color: JepretColor.PRIMARY,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Text(
                  "1",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              const SizedBox(width: 8.00,),
              Column(
                children: <Widget>[
                  Container(
                      width: 200.00,
                      height: 30.00,
                      decoration: new BoxDecoration(
                        color: JepretColor.PRIMARY_DARKER,
                        borderRadius: new BorderRadius.only(
                          topLeft: new Radius.circular(20.0),
                          topRight: new Radius.circular(20.0),
                          bottomRight: new Radius.circular(20.0),
                          bottomLeft: new Radius.circular(20.0),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(8.00, 0.00, 8, 0.00),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 10.00),
                          Text(
                            "Pertanyaan Singkat",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(65.00, 0.00, 16.00, 0.00),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text("Pertanyaan 1 dari 1"),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.0,),
                        Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18.0),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0.00, 5.00, 0.00, 0.00),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.70,
                      ),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontFamily: "NunitoSans",
                                color: JepretColor.PRIMARY_DARKER,
                                fontSize: 18
                            ),
                            children: <TextSpan>[
                              TextSpan(text: "Apakah tempat ini merupakan sebuah "),
                              TextSpan(
                                  text: "Rumah Makan",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              TextSpan(text: "?"),
                            ]
                        ),
                      ),
                    )
                  ],
                ),
                _renderYesNoButton(),
              ],
            ),
          ),
        ],
      );
    }
    else {
      content = GestureDetector(
        onTap: () {
          setState(() {
            this.step = 1;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    border: new Border.all(
                        color: Colors.black12,
                        width: 3.5,
                        style: BorderStyle.solid
                    ),
                    color: Color.fromARGB(18, 0, 0, 0),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Text(
                    "1",
                    style: TextStyle(
                        color: Colors.black12,
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                const SizedBox(width: 8.00,),
                Column(
                  children: <Widget>[
                    Container(
                        width: 200.00,
                        height: 30.00,
                        decoration: new BoxDecoration(
//                      color: JepretColor.PRIMARY_DARKER,
                          borderRadius: new BorderRadius.only(
                            topLeft: new Radius.circular(20.0),
                            topRight: new Radius.circular(20.0),
                            bottomRight: new Radius.circular(20.0),
                            bottomLeft: new Radius.circular(20.0),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(8.00, 0.00, 8, 0.00),
                        child: Row(
                          children: <Widget>[
                            const SizedBox(width: 10.00),
                            Text(
                              "Pertanyaan Singkat",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      );
    }
    return content;
  }

  Widget _renderStep2(BuildContext context, int step) {
    Widget content;

    if (step == 2) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  border: new Border.all(
                      color: JepretColor.PRIMARY_DARKER,
                      width: 3.5,
                      style: BorderStyle.solid
                  ),
                  color: JepretColor.PRIMARY,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Text(
                  "2",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              const SizedBox(width: 8.00,),
              Column(
                children: <Widget>[
                  Container(
                      width: 200.00,
                      height: 30.00,
                      decoration: new BoxDecoration(
                        color: JepretColor.PRIMARY_DARKER,
                        borderRadius: new BorderRadius.only(
                          topLeft: new Radius.circular(20.0),
                          topRight: new Radius.circular(20.0),
                          bottomRight: new Radius.circular(20.0),
                          bottomLeft: new Radius.circular(20.0),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(8.00, 0.00, 8, 0.00),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 10.00),
                          Text(
                            "Ambil Foto Tempatnya",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(65.00, 0.00, 16.00, 0.00),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.60,
                        maxHeight: MediaQuery.of(context).size.width * 0.50,
                      ),
                      decoration: new BoxDecoration(
//                      color: JepretColor.PRIMARY_DARKER,
                        border: new Border.all(
                            color: JepretColor.PRIMARY_DARKER,
                            width: 3.5,
                            style: BorderStyle.solid
                        ),
//                      borderRadius: new BorderRadius.only(
//                        topLeft: new Radius.circular(20.0),
//                        topRight: new Radius.circular(20.0),
//                        bottomRight: new Radius.circular(20.0),
//                        bottomLeft: new Radius.circular(20.0),
//                      ),
                      ),
                      child: _image == null
                          ? Text('Tolong ambil foto.')
                          : new Image.file(_image),
                    ),
                    const SizedBox(width: 50,)
                  ],
                ),
                _renderJepretButton(),
              ],
            ),
          ),
        ],
      );
    }
    else {
      content = GestureDetector(
        onTap: () {
          setState(() {
            this.step = 2;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    border: new Border.all(
                        color: Colors.black12,
                        width: 3.5,
                        style: BorderStyle.solid
                    ),
                    color: Color.fromARGB(18, 0, 0, 0),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Text(
                    "2",
                    style: TextStyle(
                        color: Colors.black12,
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                const SizedBox(width: 8.00,),
                Column(
                  children: <Widget>[
                    Container(
                        width: 200.00,
                        height: 30.00,
                        decoration: new BoxDecoration(
//                      color: JepretColor.PRIMARY_DARKER,
                          borderRadius: new BorderRadius.only(
                            topLeft: new Radius.circular(20.0),
                            topRight: new Radius.circular(20.0),
                            bottomRight: new Radius.circular(20.0),
                            bottomLeft: new Radius.circular(20.0),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(8.00, 0.00, 8, 0.00),
                        child: Row(
                          children: <Widget>[
                            const SizedBox(width: 10.00),
                            Text(
                              "Ambil Foto Tempatnya",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      );
    }
    return content;
  }

  Widget _renderJepretButton() {
    return Container(
        padding: EdgeInsets.fromLTRB(0.00, 12.00, 0.00, 0.00),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 130,
              child: OutlinedPrimaryButton(
                text: "Jepret",
                onPressed: () {
                  getImage();
                  setState(() {
                    step = 3;
                  });
                  if (lastStep < 2) {
                    this.setState(() {
                      lastStep = 2;
                    });
                  }
                },
              ),
            ),
            const SizedBox(width: 50),
          ],
        )
    );
  }

  Widget _renderStep3(BuildContext context, int step) {
    Widget content;

    if (step == 3) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  border: new Border.all(
                      color: JepretColor.PRIMARY_DARKER,
                      width: 3.5,
                      style: BorderStyle.solid
                  ),
                  color: JepretColor.PRIMARY,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Text(
                  "3",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              const SizedBox(width: 8.00,),
              Column(
                children: <Widget>[
                  Container(
                      width: 200.00,
                      height: 30.00,
                      decoration: new BoxDecoration(
                        color: JepretColor.PRIMARY_DARKER,
                        borderRadius: new BorderRadius.only(
                          topLeft: new Radius.circular(20.0),
                          topRight: new Radius.circular(20.0),
                          bottomRight: new Radius.circular(20.0),
                          bottomLeft: new Radius.circular(20.0),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(8.00, 0.00, 8, 0.00),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 10.00),
                          Text(
                            "Beri Bintangnya",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(65.00, 0.00, 16.00, 0.00),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text("Langkah ini opsional"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _renderRating(),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
    else {
      content = GestureDetector(
        onTap: () {
          setState(() {
            this.step = 3;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    border: new Border.all(
                        color: Colors.black12,
                        width: 3.5,
                        style: BorderStyle.solid
                    ),
                    color: Color.fromARGB(18, 0, 0, 0),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Text(
                    "3",
                    style: TextStyle(
                        color: Colors.black12,
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                const SizedBox(width: 8.00,),
                Column(
                  children: <Widget>[
                    Container(
                        width: 200.00,
                        height: 30.00,
                        decoration: new BoxDecoration(
//                      color: Color.fromARGB(18, 0, 0, 0),
                          borderRadius: new BorderRadius.only(
                            topLeft: new Radius.circular(20.0),
                            topRight: new Radius.circular(20.0),
                            bottomRight: new Radius.circular(20.0),
                            bottomLeft: new Radius.circular(20.0),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(8.00, 0.00, 8, 0.00),
                        child: Row(
                          children: <Widget>[
                            const SizedBox(width: 10.00),
                            Text(
                              "Beri Bintangnya",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
    return content;
  }

  Widget _renderRating() {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: Icon(
            Icons.star,
            color: rating < 1 ? Colors.black12 : Colors.yellow,
            size: 54.0,
          ),
          onTap: () {
            setState(() {
              rating = 1;
            });
          },
        ),
        GestureDetector(
          child: Icon(Icons.star,
            color: rating < 2 ? Colors.black12 : Colors.yellow,
            size: 54.0,
          ),
          onTap: () {
            setState(() {
              rating = 2;
            });
          },
        ),
        GestureDetector(
          child: Icon(
            Icons.star,
            color: rating < 3 ? Colors.black12 : Colors.yellow,
            size: 54.0,
          ),
          onTap: () {
            setState(() {
              rating = 3;
            });
          },
        ),
        GestureDetector(
          child: Icon(Icons.star,
            color: rating < 4 ? Colors.black12 : Colors.yellow,
            size: 54.0,
          ),
          onTap: () {
            setState(() {
              rating = 4;
            });
          },
        ),
        GestureDetector(
          child: Icon(Icons.star,
            color: rating < 5 ? Colors.black12 : Colors.yellow,
            size: 54.0,
          ),
          onTap: () {
            setState(() {
              rating = 5;
            });
          },
        ),
      ],
    );
  }

  Widget _renderStep4(BuildContext context, int step) {
    Widget content;

    if (step == 4) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  border: new Border.all(
                      color: JepretColor.PRIMARY_DARKER,
                      width: 3.5,
                      style: BorderStyle.solid
                  ),
                  color: JepretColor.PRIMARY,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Text(
                  "4",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              const SizedBox(width: 8.00,),
              Column(
                children: <Widget>[
                  Container(
                      width: 200.00,
                      height: 30.00,
                      decoration: new BoxDecoration(
                        color: JepretColor.PRIMARY_DARKER,
                        borderRadius: new BorderRadius.only(
                          topLeft: new Radius.circular(20.0),
                          topRight: new Radius.circular(20.0),
                          bottomRight: new Radius.circular(20.0),
                          bottomLeft: new Radius.circular(20.0),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(8.00, 0.00, 8, 0.00),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 10.00),
                          Text(
                            "Tulis Ulasannya",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(65.00, 0.00, 16.00, 0.00),
            child: Column(
              children: <Widget>[
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  mainAxisSize: MainAxisSize.max,
//                  children: <Widget>[
//                    Text("Langkah ini opsional")
//                  ],
//                ),
              Container(height: 16),
                JepretTextField(
                  controller: _controller_review,
                  label: "Ulasan (opsional)",
                  hasFloatingPlaceholder: true,
                )
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  mainAxisSize: MainAxisSize.max,
//                  children: <Widget>[
//                    Container(
//                      padding: EdgeInsets.fromLTRB(0.00, 5.00, 0.00, 0.00),
//                      constraints: BoxConstraints(
//                        maxWidth: MediaQuery.of(context).size.width * 0.70,
//                      ),
//                      child: Container(),
//                    )
//                  ],
//                ),
              ],
            ),
          ),
        ],
      );
    }
    else {
      content = GestureDetector(
        onTap: () {
          setState(() {
            this.step = 4;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    border: new Border.all(
                        color: Colors.black12,
                        width: 3.5,
                        style: BorderStyle.solid
                    ),
                    color: Color.fromARGB(18, 0, 0, 0),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Text(
                    "4",
                    style: TextStyle(
                        color: Colors.black12,
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                const SizedBox(width: 8.00,),
                Column(
                  children: <Widget>[
                    Container(
                        width: 200.00,
                        height: 30.00,
                        decoration: new BoxDecoration(
//                      color: JepretColor.PRIMARY_DARKER,
                          borderRadius: new BorderRadius.only(
                            topLeft: new Radius.circular(20.0),
                            topRight: new Radius.circular(20.0),
                            bottomRight: new Radius.circular(20.0),
                            bottomLeft: new Radius.circular(20.0),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(8.00, 0.00, 8, 0.00),
                        child: Row(
                          children: <Widget>[
                            const SizedBox(width: 10.00),
                            Text(
                              "Tulis Ulasannya",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
    return content;
  }

  requestPermission() async {
    await PermissionHandler().requestPermissions([PermissionGroup.locationWhenInUse]);
  }

  Widget _renderBottom() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _renderBottomButton()
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _renderBottomButton() {
    return Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OutlinedPrimaryButton(
              text: "Kirim",
              onPressed: () {
                if (lastStep >= 2) _attemptSubmit();
              },
            )
          ],
        )
    );
  }

  getNearbyUMKM(BuildContext context, double lat, double lng) async {
    JepretAppState state = JepretApp.of(context);
    final String authToken = state.authentication.authToken;

    return await http.post(
        ApiEndpoints.CREATE_VERIFICATION,
        body: json.encode({
          'lat': lat,
          'lng': lng
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authToken
        }
    );
  }

  void _attemptSubmit() async {
    JepretAppState state = JepretApp.of(context);
    String sector = this.partner.sector;
    String umkm = this.partner.partnerId;

    String imageUrl = null;
    if(this._image != null) {
      dynamic response = await _upload(this._image);
      imageUrl = "${ApiEndpoints.GET_FILE}${response['data'][0]['unique_id']}";
    }

    dynamic body = {
      'umkm': int.parse(umkm),
      'photo': imageUrl,
      'qas': [
        {
          'question': 'Is it a $sector?',
          'answer': step1Ans ? 'Ya' : 'Tidak',
        }
      ],
      'star': rating,
      'review': _controller_review.text
    };

    await http.post(ApiEndpoints.CREATE_VERIFICATION, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'Authorization': state.authentication.authToken
    });

    Navigator.of(context).pop();
  }

  Future<dynamic> _upload(File imageFile) async {
    if(imageFile == null) {
      return Future.value(null);
    }

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    JepretAppState state = JepretApp.of(context);
    Map<String, String> headers = { "Authorization": state.authentication.authToken};

    var uri = Uri.parse(ApiEndpoints.UPLOAD_FILE);

    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(headers);

    var multipartFile = new http.MultipartFile('file[]', stream, length,
        filename: 'temp.jpg');
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    return json.decode(await response.stream.bytesToString());
  }
}

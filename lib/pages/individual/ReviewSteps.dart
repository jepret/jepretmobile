import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/components/OutlinedPrimaryButton.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_enums.dart';

class ReviewSteps extends StatefulWidget {
  ReviewSteps() : super();

  @override
  _ReviewStepsState createState() => _ReviewStepsState();
}

class _ReviewStepsState extends State<ReviewSteps> {
  FocusNode _focus_review = new FocusNode();
  TextEditingController _controller_review = new TextEditingController();
  int step;
  bool step1Ans;

  @override
  void initState() {
    super.initState();

    this.setState(() {
      step = 1;
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
                    Text("Pertanyaan 1 dari 2"),
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
      content = Column(
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
                      child: Image(image: NetworkImage("https://img.sndimg.com/food/image/upload/w_560,h_315,c_fill,fl_progressive,q_80/v1/img/recipes/53/74/76/83kDuWs7QsCf4oZ0rhFs_0S9A7513.jpg"),),
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
      content = Column(
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
                onPressed: () {},
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
      content = Column(
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
      );
    }
    return content;
  }

  Widget _renderRating() {
    return Row(
      children: <Widget>[
        Icon(Icons.star, color: Colors.yellow, size: 54.0,),
        Icon(Icons.star, color: Colors.black12, size: 54.0,),
        Icon(Icons.star, color: Colors.black12, size: 54.0,),
        Icon(Icons.star, color: Colors.black12, size: 54.0,),
        Icon(Icons.star, color: Colors.black12, size: 54.0,),
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
                    Container(
                      padding: EdgeInsets.fromLTRB(0.00, 5.00, 0.00, 0.00),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.70,
                      ),
                      child: JepretTextField(
//                      label: "Nama Lengkap",
                        focusNode: _focus_review,
                        controller: _controller_review,
//                      icon: Icon(Icons.person_outline),
                        hasFloatingPlaceholder: true,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
    else {
      content = Column(
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
      );
    }
    return content;
  }
}

requestPermission() async {
  await PermissionHandler.requestPermissions([PermissionGroup.locationWhenInUse]);
//  print("permission request result is " + res.toString());
}
import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/constants/Preferences.dart';
import 'package:jepret/constants/ApiEndpoints.dart';
import 'package:jepret/model/ProfileAnswers.dart';
import 'package:jepret/app.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/components/LoadingDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompleteProfileRoute extends StatefulWidget {
  CompleteProfileRouteState createState() => CompleteProfileRouteState();
}

class CompleteProfileRouteState extends State<CompleteProfileRoute> with AfterLayoutMixin<CompleteProfileRoute> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentStep = 0;
  String genderDropdownValue = 'm';
  bool needFundingDropdownValue = false;
  int other1DropdownValue = 0;
  int other2DropdownValue = 0;
  int other3DropdownValue = 0;
  ProfileAnswers profileAnswers;

  LoadingDialog _loadingDialog;

  TextEditingController _controller_name = TextEditingController();
  TextEditingController _controller_jabatan = TextEditingController();
  TextEditingController _controller_dob = TextEditingController();

  TextEditingController _controller_workforce = TextEditingController();
  TextEditingController _controller_expert = TextEditingController();

  TextEditingController _controller_gross = TextEditingController();
  TextEditingController _controller_base = TextEditingController();
  TextEditingController _controller_opcost = TextEditingController();

  TextEditingController _controller_amount = TextEditingController();
  TextEditingController _controller_duration = TextEditingController();

  Widget build(BuildContext context) {
    List<Step> steps = _getSteps();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: JepretColor.PRIMARY_DARKER),
          onPressed: () {
            Navigator.of(context).pop();
          }
        ),
        title: Text("Lengkapi Data", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
      ),
      body: Stepper(
        currentStep: currentStep,
        type: StepperType.vertical,
          onStepContinue: () {
            saveAnswers();
            setState(() {
              // update the variable handling the current step value
              // going back one step i.e adding 1, until its the length of the step
              if (currentStep < steps.length - 1) {
                currentStep++;
              } else {
                _attemptSubmit();
              }
            });
          },

          onStepCancel: () {
            // On hitting cancel button, change the state
            setState(() {
              // update the variable handling the current step value
              // going back one step i.e subtracting 1, until its 0
              if (currentStep > 0) {
                currentStep = currentStep - 1;
              } else {
                currentStep = 0;
              }
            });
          },
        steps: steps
      )
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _loadingDialog = LoadingDialog(context);
    loadAnswers();
  }

  void loadAnswers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedAnswers = await sharedPreferences.get(Preferences.PROFILE_COMPLETION);
    debugPrint("loaded! ${savedAnswers}");

    if(savedAnswers == null) {
      setState(() {
        profileAnswers = ProfileAnswers();
      });
    } else {
      profileAnswers = ProfileAnswers.fromJson(savedAnswers);
      debugPrint("loaded! ${profileAnswers.toJson()}");

      _controller_name.text = profileAnswers.ownerName;
      _controller_jabatan.text = profileAnswers.position;
      _controller_dob.text = profileAnswers.birthDate;

      _controller_workforce.text = "${profileAnswers.workerCount ?? ''}";
      _controller_expert.text = "${profileAnswers.expertCount ?? ''}";

      _controller_gross.text = "${profileAnswers.grossRevenue ?? ''}";
      _controller_base.text = "${profileAnswers.averagePrice ?? ''}";
      _controller_opcost.text = "${profileAnswers.operationalCost ?? ''}";

      _controller_amount.text = "${profileAnswers.fundingAmount ?? ''}";
      _controller_duration.text = "${profileAnswers.fundingMonthCount ?? ''}";

      setState(() {
        genderDropdownValue = profileAnswers.gender ?? 'm';
        needFundingDropdownValue = profileAnswers.needFunding ?? false;
        other1DropdownValue = profileAnswers.moneyEqSuccess ?? 0;
        other2DropdownValue = profileAnswers.moneyEqCompetence ?? 0;
        other3DropdownValue = profileAnswers.doCareMoney ?? 0;
      });
    }
  }

  void saveAnswers() async {
    debugPrint("saving");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    profileAnswers.ownerName = _controller_name.text;
    profileAnswers.position = _controller_jabatan.text;
    profileAnswers.birthDate = _controller_dob.text;

    profileAnswers.workerCount = (_controller_workforce.text.isEmpty) ? null : int.parse(_controller_workforce.text);
    profileAnswers.expertCount = (_controller_expert.text.isEmpty) ? null : int.parse(_controller_expert.text);

    profileAnswers.grossRevenue = (_controller_gross.text.isEmpty) ? null : int.parse(_controller_gross.text);
    profileAnswers.averagePrice = (_controller_base.text.isEmpty) ? null : int.parse(_controller_base.text);
    profileAnswers.operationalCost = (_controller_opcost.text.isEmpty) ? null : int.parse(_controller_opcost.text);

    profileAnswers.fundingAmount = (_controller_amount.text.isEmpty) ? null : int.parse(_controller_amount.text);
    profileAnswers.fundingMonthCount = (_controller_duration.text.isEmpty) ? null : int.parse(_controller_duration.text);

    profileAnswers.gender = genderDropdownValue;
    profileAnswers.needFunding = needFundingDropdownValue;
    profileAnswers.moneyEqSuccess = other1DropdownValue;
    profileAnswers.moneyEqCompetence = other2DropdownValue;
    profileAnswers.doCareMoney = other3DropdownValue;

    await sharedPreferences.setString(Preferences.PROFILE_COMPLETION, profileAnswers.toJson());
    debugPrint("saved! ${ profileAnswers.toJson()}");
  }

  List<Step> _getSteps() {
    return <Step>[
      Step(
          title: Text("Biodata"),
          content: _renderBiodataPane(),
        isActive: currentStep == 0,
      ),
      Step(
          title: Text("Tenaga Kerja"),
          content: _renderWorkforcePane(),
        isActive: currentStep == 1,
      ),
      Step(
        title: Text("Keuangan"),
          content: _renderFinancePane(),
        isActive: currentStep == 2,
      ),
      Step(
        title: Text("Penjaminan"),
          content: _renderInsurancePane(),
        isActive: currentStep == 3,
      ),
      Step(
        title: Text("Lain-lain"),
          content: _renderOthersPane(),
        isActive: currentStep == 4,
      )
    ];
  }

  Widget _renderBiodataPane() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          JepretTextField(
            controller: _controller_name,
            label: "Nama sesuai KTP",
            hasFloatingPlaceholder: true,
          ),
          Container(height: 16),
          JepretTextField(
            controller: _controller_jabatan,
            label: "Jabatan dalam usaha",
            hasFloatingPlaceholder: true,
          ),
          Container(height: 16),
          JepretTextField(
            controller: _controller_dob,
            label: "Tanggal lahir",
            hasFloatingPlaceholder: true,
            hint: "DD-MM-YYYY",
          ),
          Container(height: 24),
          Text("Jenis Kelamin"),
          Row(
            children: <Widget>[
              DropdownButton<String>(
                  hint: Text("Jenis Kelamin"),
                  value: genderDropdownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      genderDropdownValue = newValue;
                    });
                  },
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem<String>(
                      value: 'm',
                      child: Text("Laki-laki"),
                    ),
                    DropdownMenuItem<String>(
                      value: 'f',
                      child: Text("Perempuan"),
                    )
                  ]
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _renderWorkforcePane() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          JepretTextField(
            controller: _controller_workforce,
            label: "Jumlah tenaga kerja",
            hasFloatingPlaceholder: true,
            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
          ),
          Container(height: 16),
          JepretTextField(
            controller: _controller_expert,
            label: "Jumlah tenaga ahli",
            hasFloatingPlaceholder: true,
            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
          ),
        ],
      ),
    );
  }


  Widget _renderFinancePane() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          JepretTextField(
            controller: _controller_gross,
            label: "Total Omset (Rp)",
            hasFloatingPlaceholder: true,
            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
          ),
          Container(height: 16),
          JepretTextField(
            controller: _controller_base,
            label: "Harga Pokok Penjualan (HPP)",
            hasFloatingPlaceholder: true,
            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
          ),
          Container(height: 16),
          JepretTextField(
            controller: _controller_opcost,
            label: "Beban Operasional",
            hasFloatingPlaceholder: true,
            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
          ),
        ],
      ),
    );
  }

  Widget _renderInsurancePane() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Apakah Saudara membutuhkan pembiayaan?"),
          Row(
            children: <Widget>[
              DropdownButton<bool>(
                  value: needFundingDropdownValue,
                  onChanged: (bool newValue) {
                    setState(() {
                      needFundingDropdownValue = newValue;
                    });
                  },
                  items: <DropdownMenuItem<bool>>[
                    DropdownMenuItem<bool>(
                      value: true,
                      child: Text("Butuh"),
                    ),
                    DropdownMenuItem<bool>(
                      value: false,
                      child: Text("Tidak"),
                    )
                  ]
              ),
            ],
          ),
          Container(height: 16),
          JepretTextField(
            controller: _controller_amount,
            label: "Jumlah kebutuhan pembiayaan",
            hasFloatingPlaceholder: true,
            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
          ),
          Container(height: 16),
          JepretTextField(
            controller: _controller_duration,
            label: "Lama angsuran (dalam bulan)",
            hasFloatingPlaceholder: true,
            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
          ),
        ],
      ),
    );
  }

  Widget _renderOthersPane() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Jawab pertanyaan-pertanyaan di bawah ini dengan memilih apakah Anda setuju atau tidak.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(height: 24),
          Text("Uang adalah simbol dan lambang dari sebuah kesuksesan"),
          Row(
            children: <Widget>[
              DropdownButton<int>(
                  value: other1DropdownValue,
                  onChanged: (int newValue) {
                    setState(() {
                      other1DropdownValue = newValue;
                    });
                  },
                  items: _renderOptions()
              ),
            ],
          ),
          Container(height: 16),
          Text("Uang akan membantu Anda untuk mengekspresikan kompetensi dan kemampuan yang Anda miliki"),
          Row(
            children: <Widget>[
              DropdownButton<int>(
                  value: other2DropdownValue,
                  onChanged: (int newValue) {
                    setState(() {
                      other2DropdownValue = newValue;
                    });
                  },
                  items: _renderOptions()
              ),
            ],
          ),
          Container(height: 16),
          Text("Saya menghargai nilai uang dengan sangat tinggi"),
          Row(
            children: <Widget>[
              DropdownButton<int>(
                  value: other3DropdownValue,
                  onChanged: (int newValue) {
                    setState(() {
                      other3DropdownValue = newValue;
                    });
                  },
                  items: _renderOptions()
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> _renderOptions() {
    return <DropdownMenuItem<int>>[
      DropdownMenuItem<int>(
        value: 0,
        child: Text("Belum memilih"),
      ),
      DropdownMenuItem<int>(
        value: 1,
        child: Text("Sangat tidak setuju"),
      ),
      DropdownMenuItem<int>(
        value: 2,
        child: Text("Tidak setuju"),
      ),
      DropdownMenuItem<int>(
        value: 3,
        child: Text("Netral"),
      ),
      DropdownMenuItem<int>(
        value: 4,
        child: Text("Setuju"),
      ),
      DropdownMenuItem<int>(
        value: 5,
        child: Text("Sangat setuju"),
      )
    ];
  }

  void _attemptSubmit() {
    _loadingDialog.show();

    JepretAppState state = JepretApp.of(context);

    dynamic body = {
      'owner_name': _controller_name.text,
      'position': _controller_jabatan.text,
      'gender': genderDropdownValue,
      'birth_date': _controller_dob.text,
      'expert_count': int.parse(_controller_expert.text ?? '0'),
      'worker_count': int.parse(_controller_workforce.text ?? '0'),
      'gross_revenue': int.parse(_controller_gross.text ?? '0'),
      'average_price': int.parse(_controller_base.text ?? '0'),
      'operational_cost': int.parse(_controller_opcost.text ?? '0'),
      'need_funding': needFundingDropdownValue,
      'funding_amount': int.parse(_controller_amount.text ?? '0'),
      'funding_month_count': int.parse(_controller_duration.text ?? '0'),
      'money_eq_success': other1DropdownValue,
      'money_eq_competence': other2DropdownValue,
      'do_care_money': other3DropdownValue,
    };

    http.post(
      ApiEndpoints.COMPLETE_UMKM_PROFILE_URL,
      body: json.encode(body),
      headers: {
          'Content-Type': 'application/json',
          'Authorization': state.authentication.authToken
      }
    )
    .then((http.Response response) {
      _loadingDialog.hide();

      String responseBody = response.body;
      Map<String, dynamic> map = json.decode(responseBody);

      if(response.statusCode != 200) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(map['message'].toString()))
        );

        return;
      }

      Navigator.of(context).pop(true);
    })
    .catchError((error) {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(error.toString()))
      );
    });
  }
}
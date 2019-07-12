import 'dart:convert';

class ProfileAnswers {
  String ownerName, position, gender;
  String birthDate;
  int expertCount, workerCount;
  int grossRevenue, averagePrice, operationalCost;
  bool needFunding;
  int fundingAmount, fundingMonthCount;
  int moneyEqSuccess, moneyEqCompetence, doCareMoney;

  ProfileAnswers({
    this.ownerName, this.position, this.gender,
    this.birthDate,
    this.expertCount, this.workerCount,
    this.grossRevenue, this.averagePrice, this.operationalCost,
    this.needFunding,
    this.fundingAmount, this.fundingMonthCount,
    this.moneyEqSuccess, this.moneyEqCompetence, this.doCareMoney
  });

  ProfileAnswers.fromMap(Map<String, dynamic> map) {
    fromMap(map);
  }

  ProfileAnswers.fromJson(String str) {
    Map<String, dynamic> map = json.decode(str);
    fromMap(map);
  }

  void fromMap(Map<String, dynamic> map) {
    this.ownerName = map['on'];
    this.position = map['pos'];
    this.gender = map['gen'];
    this.birthDate = map['dob'];
    this.expertCount = map['expc'];
    this.workerCount = map['worc'];
    this.grossRevenue = map['gross'];
    this.averagePrice = map['avgp'];
    this.operationalCost = map['opc'];
    this.needFunding = map['nedf'];
    this.fundingAmount = map['fund'];
    this.fundingMonthCount = map['funmc'];
    this.moneyEqSuccess = map['mons'];
    this.moneyEqCompetence = map['monc'];
    this.doCareMoney = map['docm'];
  }

  Map<String, dynamic> toMap() {
    return {
      'on': this.ownerName,
      'pos': this.position,
      'gen': this.gender,
      'dob': this.birthDate,
      'expc': this.expertCount,
      'worc': this.workerCount,
      'gross': this.grossRevenue,
      'avgp': this.averagePrice,
      'opc': this.operationalCost,
      'nedf': needFunding,
      'fund': fundingAmount,
      'funmc': fundingMonthCount,
      'mons': moneyEqSuccess,
      'monc': moneyEqCompetence,
      'docm': doCareMoney,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }
}
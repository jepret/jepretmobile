import 'package:jepret/model/Partner.dart';

class Transaction {
  int amount;
  int id;
  Partner recipient;

  Transaction({this.amount, this.recipient, this.id});
}
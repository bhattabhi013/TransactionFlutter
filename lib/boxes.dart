import 'package:hive/hive.dart';
import 'package:transactions/model/transactions_model.dart';

class Boxes {
  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>('transactions');
}

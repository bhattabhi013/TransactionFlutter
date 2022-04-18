import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'transactions_model.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late DateTime dateTime;
  @HiveField(2)
  late bool isExpense;
  @HiveField(3)
  late double amount;
}

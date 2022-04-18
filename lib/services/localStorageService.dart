import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneytr/widgets/transactionItem.dart';

class localStorageService {
  static const String transactionBoxKey = "transactionBox";
  static const String balanceBoxKey = "balanceBoxKey";
  static const String budgetBoxKey = "budgetBoxKey";

  static final localStorageService _instance = localStorageService._internal();

  factory localStorageService() {
    return _instance;
  }

  localStorageService._internal();

  Future<void> initializeHIve() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TransactionItemAdapter());
    }

    await Hive.openBox(balanceBoxKey);
    await Hive.openBox(transactionBoxKey);
    await Hive.openBox(budgetBoxKey);
  }

  void saveTransactionItem(TransactionItem transaction) {
    Hive.box<TransactionItem>(transactionBoxKey).add(transaction);
    saveBalance(transaction);
  }

  List<TransactionItem> getAllTransactions() {
    return Hive.box<TransactionItem>(transactionBoxKey).values.toList();
  }

  ///save?get balance method

  Future<void> saveBalance(TransactionItem item) async {
    final balanceBox = Hive.box<double>(balanceBoxKey);
    final currentBalance = balanceBox.get("balance") ?? 0.0;
    if (item.isExpense) {
      balanceBox.put("balance", currentBalance + item.amount);
    } else {
      balanceBox.put("balance", currentBalance - item.amount);
    }
  }

//get our balance

  double getBalance() {
    return Hive.box<double>(balanceBoxKey).get("balance") ??
        0.0; //  0.0 if it is null value
  }

  double getBudget() {
    return Hive.box<double>(budgetBoxKey).get("budget") ?? 2000;
  }

  Future<void> saveBudget(double value) {
    return Hive.box<double>(budgetBoxKey).put("budget", value);
  }
}

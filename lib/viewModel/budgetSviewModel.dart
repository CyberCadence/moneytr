import 'package:flutter/foundation.dart';
import 'package:moneytr/services/localStorageService.dart';
import 'package:moneytr/widgets/transactionItem.dart';

class BudgetViewModel extends ChangeNotifier {
  double getBudget() => localStorageService().getBudget();
  double getBalance() => localStorageService().getBalance();
  List<TransactionItem> get items => localStorageService().getAllTransactions();

  set budget(double value) {
    localStorageService().saveBudget(value);
    notifyListeners();
  }

  void addItem(TransactionItem item) {
    localStorageService().saveTransactionItem(item);
    notifyListeners();
  }

  void deleteItem(TransactionItem item) {
    final localstorage = localStorageService();
    localstorage.deleteTransactionitem;

    notifyListeners();
  }
}

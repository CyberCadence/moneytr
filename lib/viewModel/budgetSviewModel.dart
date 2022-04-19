import 'package:flutter/foundation.dart';
import 'package:moneytr/services/localStorageService.dart';
import 'package:moneytr/widgets/transactionItem.dart';

class BudgetViewModel extends ChangeNotifier {
  double getBudget() => LocalStorageService().getBudget();
  double getBalance() => LocalStorageService().getBalance();
  List<TransactionItem> get items => LocalStorageService().getAllTransactions();

  set budget(double value) {
    LocalStorageService().saveBudget(value);
    notifyListeners();
  }

  void addItem(TransactionItem item) {
    LocalStorageService().saveTransactionItem(item);
    notifyListeners();
  }

  void deleteItem(TransactionItem item) {
    final localstorage = LocalStorageService();
    localstorage.deleteTransactionItem(item);

    notifyListeners();
  }
}

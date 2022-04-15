import 'package:flutter/foundation.dart';
import 'package:moneytr/widgets/transactionItem.dart';

class BudgetService extends ChangeNotifier {
  double _budget = 2000;
  double get budget => _budget;

  set budget(double value) {
    _budget = value;

    notifyListeners();
  }

  List<TransactionItem> _items = [];
  double balance = 0.0;

  List<TransactionItem> get items => _items;

  void addItems(TransactionItem item) {
    _items.add(item);
    updateBalance(item);
    notifyListeners();
  }

  void updateBalance(TransactionItem item) {
    if (item.isExpense) {
      balance += item.amount;
    } else {
      balance -= item.amount;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneytr/widgets/transactionItem.dart';

class addTransaction extends StatefulWidget {
  final Function(TransactionItem) itemtoAdd;

  addTransaction({required this.itemtoAdd});
  @override
  State<addTransaction> createState() => _addTransactionState();
}

class _addTransactionState extends State<addTransaction> {
  bool _isExpensiveController = true;
  final TextEditingController itemTitleController = TextEditingController();
  final TextEditingController itemAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 200,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                'Add expense',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: itemTitleController,
                decoration:
                    const InputDecoration(hintText: ' Add Expense here'),
              ),
              TextField(
                controller: itemAmountController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(hintText: "Amount in \$"),
              ),
              Row(
                children: [
                  Text('Is Expensive?'),
                  Switch(
                      value: _isExpensiveController,
                      onChanged: (booll) {
                        setState(() {
                          _isExpensiveController = booll;
                        });
                      }),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (itemAmountController.text.isNotEmpty &&
                        itemTitleController.text.isNotEmpty) {
                      widget.itemtoAdd(
                        TransactionItem(
                            isExpense: _isExpensiveController,
                            amount: double.parse(itemAmountController.text),
                            itemTitle: itemTitleController.text),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'))
            ],
          ),
        ),
      ),
    );
  }
}

class addBudgetWidget extends StatefulWidget {
  addBudgetWidget({Key? key,required this.budgettoAdd}) : super(key: key);
  final Function(double) budgettoAdd;
  @override
  State<addBudgetWidget> createState() => _addBudgetWidgetState();
}

class _addBudgetWidgetState extends State<addBudgetWidget> {
  final TextEditingController _budgetTracker = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1 / 3,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text(
                'Add budget',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _budgetTracker,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(hintText: 'add your budget'),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_budgetTracker.text.isNotEmpty) {
                      widget.budgettoAdd(double.parse(_budgetTracker.text));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'))
            ],
          ),
        ),
      ),
    );
  }
}

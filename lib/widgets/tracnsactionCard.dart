import 'package:flutter/material.dart';
import 'package:moneytr/viewModel/budgetSviewModel.dart';
import 'package:provider/provider.dart';
import 'transactionItem.dart';

class TransactionCard extends StatelessWidget {
  final TransactionItem item;
  const TransactionCard({required this.item, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: const Offset(0, 25),
              blurRadius: 50,
            )
          ],
        ),
        padding: const EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                final budgetviewModel =
                    Provider.of<BudgetViewModel>(context, listen: false);
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.black38,
                                Colors.white.withOpacity(0.4)
                              ]),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder()),
                                    onPressed: () {
                                      budgetviewModel.deleteItem(item);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('yes')),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder()),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('no'))
                              ],
                            ),
                            height: 100,
                            width: 50),
                      );
                    });

                // budgetviewModel.deleteItem(item);
              },
              child: const Text('delete item'),
            ),
            const Spacer(),
            Text(
              item.itemTitle,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Text(
              (!item.isExpense ? "+ " : "- ") + item.amount.toString(),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

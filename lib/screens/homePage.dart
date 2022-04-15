import 'package:flutter/material.dart';
import 'package:moneytr/services/budgetService.dart';
import 'package:moneytr/widgets/addTransaction.dart';
import 'package:moneytr/widgets/transactionItem.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../widgets/tracnsactionCard.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return addTransaction(
                  itemtoAdd: (transactionItem) {
                    final budgetService =
                        Provider.of<BudgetService>(context, listen: false);
                    budgetService.addItems(transactionItem);
                    // setState(() {
                    //   items.add(transactionItem);
                    // });
                  },
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: screenSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Consumer<BudgetService>(
                      builder: ((context, value, child) {
                        return CircularPercentIndicator(
                          radius: screenSize.width / 2,
                          lineWidth: 10.0,
                          percent: value.balance / value.budget,
                          backgroundColor: Colors.white,
                          center: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "\$" + value.balance.toString().split(".")[0],
                                style: const TextStyle(
                                    fontSize: 48, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Balance",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "Budget: \$" + value.budget.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          progressColor: Theme.of(context).colorScheme.primary,
                        );
                      }),
                    )),
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  "Items",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<BudgetService>(
                  builder: ((context, value, child) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.items.length,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TransactionCard(
                            item: value.items[index],
                          );
                        });
                    //  List.generate(
                    // items.length,
                    // (index) => TransactionCard(
                    //       item: items[index],
                    //     )),
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
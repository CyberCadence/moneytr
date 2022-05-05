import 'package:flutter/material.dart';
 
import 'package:moneytr/viewModel/budgetSviewModel.dart';
import 'package:moneytr/widgets/addTransaction.dart';
 
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../services/theme_services.dart';
import '../widgets/tracnsactionCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
     
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return addTransaction(
                  itemtoAdd: (transactionItem) {
                    final budgetService =
                        Provider.of<BudgetViewModel>(context, listen: false);
                    budgetService.addItem(transactionItem);
                     
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
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Consumer<BudgetViewModel>(
                      builder: ((context, value, child) {
                        final balance = value.getBalance();
                        final budget = value.getBudget();
                        double percentage = balance / budget;
                        if (percentage < 0) {
                          percentage = 0;
                        }
                        if (percentage > 1) {
                          percentage = 1;
                        }

                        return CircularPercentIndicator(
                          radius:  MediaQuery.of(context).size.width>=650?200:MediaQuery.of(context).size.width/2,
                          lineWidth: 10.0,
                          percent: percentage,
                          backgroundColor: themeService.darkTheme?Colors.white:Colors.blueAccent,
                          center: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "\$" + balance.toString().split(".")[0],
                                style: const TextStyle(
                                    fontSize: 48, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Balance",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "Budget: \$" + budget.toString(),
                                style: const TextStyle(fontSize: 25),
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
                Consumer<BudgetViewModel>(
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

 
 
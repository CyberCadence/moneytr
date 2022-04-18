import 'package:flutter/material.dart';
import 'package:moneytr/screens/homePage.dart';
import 'package:moneytr/screens/profilePage.dart';
import 'package:moneytr/viewModel/budgetSviewModel.dart';
import 'package:moneytr/services/theme_services.dart';
import 'package:moneytr/widgets/addTransaction.dart';
import 'package:provider/provider.dart';

class Homee extends StatefulWidget {
  Homee({Key? key}) : super(key: key);

  @override
  State<Homee> createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile')
  ];
  List<Widget> pages = [HomePage(), ProfilePage()];
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            themeService.darkTheme = !themeService.darkTheme;
          },
          icon: Icon(themeService.darkTheme ? Icons.sunny : Icons.dark_mode),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return addBudgetWidget(budgettoAdd: (budget) {
                        final budgetService =
                            Provider.of<BudgetViewModel>(context, listen: false);
                        budgetService.budget = budget;
                      });
                    });
              },
              icon: const Icon(Icons.attach_money))
        ],
        title: const Text('Money Track app'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        items: bottomNavItems,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
      body: pages[_currentPageIndex],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:moneytr/screens/home.dart';

import 'package:moneytr/viewModel/budgetSviewModel.dart';
import 'package:moneytr/services/localStorageService.dart';

import 'package:provider/provider.dart';
import 'package:moneytr/services/theme_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorageServicee = LocalStorageService();
 await  localStorageServicee.initializeHive();
  final sharedPreference = await SharedPreferences.getInstance();
  return runApp(MyApp(
    sharedPreferences: sharedPreference,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({Key? key, required this.sharedPreferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeService>(
              create: (_) => ThemeService(sharedPreferences)),
          ChangeNotifierProvider<BudgetViewModel>(create: (_) => BudgetViewModel())
        ],
        child: Builder(
          builder: (BuildContext context) {
            final themeService = Provider.of<ThemeService>(context);
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                      brightness: themeService.darkTheme
                          ? Brightness.dark
                          : Brightness.light,
                      seedColor: Colors.indigo),
                ),
                home: Homee());
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/budget_state.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BudgetState(),
      child: const BudgetPrototypeApp(),
    ),
  );
}

class BudgetPrototypeApp extends StatelessWidget {
  const BudgetPrototypeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Prototype',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

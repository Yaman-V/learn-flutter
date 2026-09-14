import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/budget_state.dart';
import 'screens/onboarding_screen.dart';

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
    final state = context.watch<BudgetState>();

    return MaterialApp(
      title: 'Budget Prototype',
      themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}

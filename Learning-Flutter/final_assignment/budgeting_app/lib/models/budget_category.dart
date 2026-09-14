import 'dart:ui';

class BudgetCategory {
  final String id;
  final String name;
  final double budgetedAmount;
  double spentAmount;
  final Color color;

  BudgetCategory({
    required this.id,
    required this.name,
    required this.budgetedAmount,
    this.spentAmount = 0.0,
    required this.color,
  });
}

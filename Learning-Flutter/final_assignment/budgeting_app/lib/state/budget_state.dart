import 'package:flutter/material.dart';
import '../models/budget_category.dart';
import '../models/transaction.dart';

class BudgetState extends ChangeNotifier {
  double accountBalance = 3500.00;

  List<BudgetCategory> categories = [
    BudgetCategory(id: '1', name: 'Rent', budgetedAmount: 1200, color: Colors.blue),
    BudgetCategory(id: '2', name: 'Groceries', budgetedAmount: 500, color: Colors.orange),
    BudgetCategory(id: '3', name: 'Transport', budgetedAmount: 150, color: Colors.purple),
    BudgetCategory(id: '4', name: 'Dining out', budgetedAmount: 200, color: Colors.teal),
    BudgetCategory(id: '5', name: 'Fun', budgetedAmount: 100, color: Colors.pink),
  ];

  List<Transaction> transactions = [];

  double get totalSpent => categories.fold(0, (sum, cat) => sum + cat.spentAmount);

  void addTransaction(Transaction tx) {
    transactions.insert(0, tx);
    transactions.sort((a, b) => b.date.compareTo(a.date));

    accountBalance -= tx.amount;

    final catIndex = categories.indexWhere((c) => c.id == tx.categoryId);
    if (catIndex != -1) {
      categories[catIndex].spentAmount += tx.amount;
    }

    notifyListeners();
  }
}

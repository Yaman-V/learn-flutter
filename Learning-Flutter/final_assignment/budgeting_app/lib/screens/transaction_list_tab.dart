import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../state/budget_state.dart';

class TransactionListTab extends StatelessWidget {
  const TransactionListTab({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BudgetState>();
    final currencyFormatter = NumberFormat.currency(symbol: '\$');
    final dateFormatter = DateFormat('MMM dd, yyyy');

    if (state.transactions.isEmpty) {
      return const Center(child: Text('No transactions found.'));
    }

    return ListView.builder(
      itemCount: state.transactions.length,
      itemBuilder: (context, index) {
        final tx = state.transactions[index];
        final category = state.categories.firstWhere((c) => c.id == tx.categoryId);

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: category.color.withOpacity(0.2),
            child: Icon(Icons.receipt, color: category.color),
          ),
          title: Text(tx.note.isEmpty ? 'Untitled' : tx.note),
          subtitle: Text('${category.name} • ${dateFormatter.format(tx.date)}'),
          trailing: Text(
            '-${currencyFormatter.format(tx.amount)}',
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}

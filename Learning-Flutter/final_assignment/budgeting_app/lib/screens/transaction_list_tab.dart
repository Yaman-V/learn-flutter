import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../state/budget_state.dart';
import 'add_transaction_screen.dart';

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

        // Handle case where category might have been deleted
        final categoryIndex = state.categories.indexWhere(
          (c) => c.id == tx.categoryId,
        );
        final categoryName = categoryIndex != -1
            ? state.categories[categoryIndex].name
            : 'Deleted Category';
        final categoryColor = categoryIndex != -1
            ? state.categories[categoryIndex].color
            : Colors.grey;

        return ListTile(
          onTap: () {
            // Open the form, passing the existing transaction
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AddTransactionScreen(existingTransaction: tx),
                fullscreenDialog: true,
              ),
            );
          },
          leading: CircleAvatar(
            backgroundColor: categoryColor.withOpacity(0.2),
            child: Icon(Icons.receipt, color: categoryColor),
          ),
          title: Text(tx.note.isEmpty ? 'Untitled' : tx.note),
          subtitle: Text('$categoryName • ${dateFormatter.format(tx.date)}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '-${currencyFormatter.format(tx.amount)}',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        );
      },
    );
  }
}

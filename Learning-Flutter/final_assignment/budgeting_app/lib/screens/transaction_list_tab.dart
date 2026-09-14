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
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
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

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.035),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
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
                backgroundColor: categoryColor.withValues(alpha: 0.2),
                child: Icon(Icons.receipt, color: categoryColor),
              ),
              title: Text(
                tx.note.isEmpty ? 'Untitled' : tx.note,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                '$categoryName • ${dateFormatter.format(tx.date)}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
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
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

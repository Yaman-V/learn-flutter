import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/models/budget_category.dart';
import '../state/budget_state.dart';

class BudgetOverviewTab extends StatelessWidget {
  const BudgetOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BudgetState>();
    final currencyFormatter = NumberFormat.currency(symbol: '\$');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Available Balance',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                currencyFormatter.format(state.accountBalance),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  // Add this color condition
                  color: state.accountBalance < 0 ? Colors.redAccent : null,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: state.totalSpent == 0
              ? const Center(child: Text('No spending yet. Add a transaction!'))
              : PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 50,
                    sections: state.categories
                        .where((c) => c.spentAmount > 0)
                        .map((cat) {
                          final percentage =
                              (cat.spentAmount / state.totalSpent) * 100;
                          return PieChartSectionData(
                            color: cat.color,
                            value: cat.spentAmount,
                            title: '${percentage.toStringAsFixed(0)}%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        })
                        .toList(),
                  ),
                ),
        ),
        const SizedBox(height: 16),

        // Category Header with Add Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => _showCategoryDialog(context),
              ),
            ],
          ),
        ),

        // Category List with Progress Bars
        Expanded(
          child: ListView.builder(
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              final cat = state.categories[index];
              final percentSpent = (cat.budgetedAmount > 0)
                  ? (cat.spentAmount / cat.budgetedAmount)
                  : 1.0;

              Color progressColor = Colors.green;
              if (percentSpent >= 1.0) {
                progressColor = Colors.red;
              } else if (percentSpent >= 0.8) {
                progressColor = Colors.amber;
              }

              // Wrap in InkWell to trigger Edit
              return InkWell(
                onTap: () =>
                    _showCategoryDialog(context, existingCategory: cat),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cat.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${currencyFormatter.format(cat.spentAmount)} / ${currencyFormatter.format(cat.budgetedAmount)}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: percentSpent.clamp(0.0, 1.0),
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        color: progressColor,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

void _showCategoryDialog(
  BuildContext context, {
  BudgetCategory? existingCategory,
}) {
  final nameController = TextEditingController(
    text: existingCategory?.name ?? '',
  );
  final budgetController = TextEditingController(
    text: existingCategory != null
        ? existingCategory.budgetedAmount.toString()
        : '',
  );

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(existingCategory == null ? 'Add Category' : 'Edit Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Category Name'),
          ),
          TextField(
            controller: budgetController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Budget Limit'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final name = nameController.text.trim();
            final budget = double.tryParse(budgetController.text) ?? 0.0;

            if (name.isNotEmpty && budget > 0) {
              if (existingCategory == null) {
                context.read<BudgetState>().addCategory(name, budget);
              } else {
                context.read<BudgetState>().editCategory(
                  existingCategory.id,
                  name,
                  budget,
                );
              }
              Navigator.pop(ctx);
            }
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

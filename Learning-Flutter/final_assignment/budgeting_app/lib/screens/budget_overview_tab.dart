import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../state/budget_state.dart';
import '../models/budget_category.dart';

class BudgetOverviewTab extends StatelessWidget {
  const BudgetOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BudgetState>();
    final currencyFormatter = NumberFormat.currency(symbol: '\$');
    final theme = Theme.of(context);

    return Column(
      children: [
        // Account Balance Header
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: state.accountBalance < 0
                    ? [const Color(0xFFB8324B), const Color(0xFF7A243E)]
                    : [const Color(0xFF087E8B), const Color(0xFF123C69)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.22),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Available Balance',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  currencyFormatter.format(state.accountBalance),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Donut Chart
        Container(
          height: 220,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
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
        const SizedBox(height: 24),

        // Category Header with Add Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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

              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 10),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 14, 12, 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.035),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              cat.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            '${currencyFormatter.format(cat.spentAmount)} / ${currencyFormatter.format(cat.budgetedAmount)}',
                            style: TextStyle(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.blueGrey,
                            ),
                            constraints:
                                const BoxConstraints(), // Keeps the icon tight to the text
                            padding: const EdgeInsets.only(left: 8.0),
                            onPressed: () => _showCategoryDialog(
                              context,
                              existingCategory: cat,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: percentSpent.clamp(0.0, 1.0),
                          backgroundColor:
                              theme.colorScheme.surfaceContainerHighest,
                          color: progressColor,
                          minHeight: 10,
                        ),
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

// Dialog Helper Function (Placed outside the class so it can be called easily)
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
            decoration: InputDecoration(
              labelText: 'Category Name',
              filled: true,
              fillColor: Theme.of(ctx).colorScheme.surfaceContainerHighest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: budgetController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Budget Limit',
              filled: true,
              fillColor: Theme.of(ctx).colorScheme.surfaceContainerHighest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
      actions: [
        if (existingCategory != null)
          TextButton(
            onPressed: () {
              context.read<BudgetState>().deleteCategory(existingCategory.id);
              Navigator.pop(ctx);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
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
              const Text('Available Balance', style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text(
                currencyFormatter.format(state.accountBalance),
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
                      final percentage = (cat.spentAmount / state.totalSpent) * 100;
                      return PieChartSectionData(
                        color: cat.color,
                        value: cat.spentAmount,
                        title: '${percentage.toStringAsFixed(0)}%',
                        radius: 40,
                        titleStyle: const TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.white
                        ),
                      );
                    }).toList(),
                  ),
                ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              final cat = state.categories[index];
              final percentSpent = (cat.spentAmount / cat.budgetedAmount);
              
              Color progressColor = Colors.green;
              if (percentSpent >= 1.0) {
                progressColor = Colors.red;
              } else if (percentSpent >= 0.8) {
                progressColor = Colors.amber;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cat.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text(
                          '${currencyFormatter.format(cat.spentAmount)} / ${currencyFormatter.format(cat.budgetedAmount)}',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: percentSpent.clamp(0.0, 1.0),
                      backgroundColor: Colors.grey.shade200,
                      color: progressColor,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

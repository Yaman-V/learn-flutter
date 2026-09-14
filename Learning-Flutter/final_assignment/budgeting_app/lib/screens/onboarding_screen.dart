import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/budget_category.dart';
import '../state/budget_state.dart';
import 'main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _balanceController = TextEditingController();

  late List<_CategoryOption> _categories;

  @override
  void initState() {
    super.initState();

    _categories = [
      _CategoryOption(
        category: BudgetCategory(
          id: 'default-rent',
          name: 'Rent',
          budgetedAmount: 1200,
          color: Colors.blue,
        ),
      ),
      _CategoryOption(
        category: BudgetCategory(
          id: 'default-groceries',
          name: 'Groceries',
          budgetedAmount: 500,
          color: Colors.orange,
        ),
      ),
      _CategoryOption(
        category: BudgetCategory(
          id: 'default-transport',
          name: 'Transport',
          budgetedAmount: 150,
          color: Colors.purple,
        ),
      ),
      _CategoryOption(
        category: BudgetCategory(
          id: 'default-dining',
          name: 'Dining out',
          budgetedAmount: 200,
          color: Colors.teal,
        ),
      ),
      _CategoryOption(
        category: BudgetCategory(
          id: 'default-fun',
          name: 'Fun',
          budgetedAmount: 100,
          color: Colors.pink,
        ),
      ),
    ];
  }

  @override
  void dispose() {
    _balanceController.dispose();
    super.dispose();
  }

  double? _parseAmount(String value) {
    return double.tryParse(value.trim());
  }

  void _showAddCustomCategoryDialog() {
    final nameController = TextEditingController();
    final budgetController = TextEditingController();
    final dialogFormKey = GlobalKey<FormState>();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Custom Category'),
          content: Form(
            key: dialogFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Category Name',
                    hintText: 'e.g. Entertainment',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter a category name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: budgetController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Budget Limit',
                    hintText: 'e.g. 250',
                    prefixText: '\$ ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter a budget limit';
                    }

                    final amount = _parseAmount(value);

                    if (amount == null || amount <= 0) {
                      return 'Enter a number greater than 0';
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (!dialogFormKey.currentState!.validate()) {
                  return;
                }

                final name = nameController.text.trim();
                final budget = _parseAmount(budgetController.text)!;

                final newCategory = BudgetCategory(
                  id: 'custom-${DateTime.now().microsecondsSinceEpoch}',
                  name: name,
                  budgetedAmount: budget,
                  color: Colors
                      .primaries[_categories.length % Colors.primaries.length],
                );

                setState(() {
                  _categories.add(
                    _CategoryOption(category: newCategory, isSelected: true),
                  );
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _getStarted() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final balance = _parseAmount(_balanceController.text)!;

    final selectedCategories = _categories
        .where((option) => option.isSelected)
        .map((option) => option.category)
        .toList();

    context.read<BudgetState>().initializeBudget(balance, selectedCategories);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 40,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),

                        // Welcome section
                        Center(
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 38,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          'Welcome to Budget Prototype',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Let\'s set up your starting balance and budget categories.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Starting balance
                        Text(
                          'Starting Account Balance',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 10),

                        TextFormField(
                          controller: _balanceController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            hintText: 'e.g. 3500',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter your starting balance';
                            }

                            final amount = _parseAmount(value);

                            if (amount == null) {
                              return 'Enter a valid number';
                            }

                            if (amount <= 0) {
                              return 'Balance must be greater than 0';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 28),

                        // Categories header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Budget Categories',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: _showAddCustomCategoryDialog,
                              icon: const Icon(Icons.add),
                              label: const Text('Add Custom'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // Checklist
                        Card(
                          elevation: 0,
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                for (
                                  int index = 0;
                                  index < _categories.length;
                                  index++
                                )
                                  CheckboxListTile(
                                    value: _categories[index].isSelected,
                                    onChanged: (selected) {
                                      setState(() {
                                        _categories[index].isSelected =
                                            selected ?? false;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      _categories[index].category.name,
                                    ),
                                    subtitle: Text(
                                      'Budget limit: \$${_categories[index].category.budgetedAmount.toStringAsFixed(2)}',
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        const Spacer(),

                        const SizedBox(height: 32),

                        // Get Started
                        SizedBox(
                          height: 52,
                          child: FilledButton(
                            onPressed: _getStarted,
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CategoryOption {
  final BudgetCategory category;
  bool isSelected;

  _CategoryOption({required this.category, this.isSelected = true});
}

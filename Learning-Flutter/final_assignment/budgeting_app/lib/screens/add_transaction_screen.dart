import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../state/budget_state.dart';
import '../models/transaction.dart';

class AddTransactionScreen extends StatefulWidget {
  final Transaction?
  existingTransaction; // If null, we add. If not null, we edit.

  const AddTransactionScreen({super.key, this.existingTransaction});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  String? _selectedCategoryId;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // If editing, pre-fill the form with existing data
    if (widget.existingTransaction != null) {
      _amountController.text = widget.existingTransaction!.amount.toString();
      _noteController.text = widget.existingTransaction!.note;
      _selectedDate = widget.existingTransaction!.date;

      // Ensure the category still exists in the state before selecting it
      final categories = context.read<BudgetState>().categories;
      if (categories.any(
        (c) => c.id == widget.existingTransaction!.categoryId,
      )) {
        _selectedCategoryId = widget.existingTransaction!.categoryId;
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submitTransaction() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);

      final state = context.read<BudgetState>();
      final isEditing = widget.existingTransaction != null;

      final transaction = Transaction(
        id: isEditing
            ? widget.existingTransaction!.id
            : DateTime.now().millisecondsSinceEpoch.toString(),
        amount: amount,
        categoryId: _selectedCategoryId!,
        note: _noteController.text.trim(),
        date: _selectedDate,
      );

      // Route to correct state method
      if (isEditing) {
        state.editTransaction(transaction.id, transaction);
      } else {
        state.addTransaction(transaction);
      }

      // Alert logic for negative balance
      if (state.accountBalance < 0) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red),
                SizedBox(width: 8),
                Text('Negative Balance'),
              ],
            ),
            content: const Text(
              'This transaction puts your account balance below zero. Please review your budget.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                },
                child: const Text('Understood'),
              ),
            ],
          ),
        );
      } else {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.read<BudgetState>().categories;
    final dateFormatter = DateFormat('MMM dd, yyyy');
    final isEditing = widget.existingTransaction != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Transaction' : 'Add Transaction'),
        actions: [
          // Show delete button only if we are editing an existing transaction
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () {
                context.read<BudgetState>().deleteTransaction(
                  widget.existingTransaction!.id,
                );
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$ ',
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter an amount';
                  final parsed = double.tryParse(value);
                  if (parsed == null || parsed <= 0)
                    return 'Amount must be greater than 0';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategoryId,
                decoration: InputDecoration(
                  labelText: 'Category',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: categories.map((cat) {
                  return DropdownMenuItem(value: cat.id, child: Text(cat.name));
                }).toList(),
                onChanged: (val) => setState(() => _selectedCategoryId = val),
                validator: (value) =>
                    value == null ? 'Please select a category' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(
                  labelText: 'Note / Payee',
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Date',
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dateFormatter.format(_selectedDate)),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              FilledButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _submitTransaction,
                child: Text(
                  isEditing ? 'Update Transaction' : 'Save Transaction',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

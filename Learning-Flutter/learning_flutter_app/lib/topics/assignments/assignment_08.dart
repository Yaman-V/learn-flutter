import 'package:flutter/material.dart';

class Assignment08 extends StatefulWidget {
  const Assignment08({super.key});

  @override
  State<Assignment08> createState() => _Assignment08State();
}

class ResultsPage extends StatelessWidget {
  final String accountType;
  final String accountNumber;
  final String accountPassword;

  const ResultsPage({
    super.key,
    required this.accountType,
    required this.accountNumber,
    required this.accountPassword,
  });

  @override
  Widget build(BuildContext context) {
    // Apply the selected color mode to this page.
    final theme = ThemeData(
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Account Information'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Registration Details',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    'Account Type',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    accountType,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Account Number',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    accountNumber,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 5),

                  Text(
                    accountPassword,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Assignment08State extends State<Assignment08> {
  final _formKey = GlobalKey<FormState>();

  String? selectedAccountType;
  String? accountNumber;
  String? accountPassword;

  InputDecoration inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),

      // Hard-coded styles
      filled: true,
      fillColor: Colors.grey.shade100,

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),

      labelStyle: const TextStyle(fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Bank Registration',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,

          autovalidateMode: AutovalidateMode.onUserInteraction,

          child: ListView(
            children: [
              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                decoration: inputDecoration(
                  label: 'Account Type',
                  icon: Icons.account_balance,
                ),

                value: selectedAccountType,

                items: ['Saving', 'Current', 'Salary']
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList(),

                onChanged: (value) {
                  setState(() {
                    selectedAccountType = value;
                  });
                },

                validator: (value) {
                  if (value == null) {
                    return 'Please enter account type';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                decoration: inputDecoration(
                  label: 'Account Number',
                  icon: Icons.account_balance,
                ),

                maxLength: 4,

                validator: (value) {
                  if (value == null || value.length != 4) {
                    return 'Account number must contain exactly 4 characters';
                  }
                  return null;
                },

                onSaved: (value) {
                  accountNumber = value;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                decoration: inputDecoration(
                  label: 'Password',
                  icon: Icons.lock,
                ),

                maxLength: 20,
                obscureText: true,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a password';
                  }

                  // More than 8 characters = minimum 9
                  final pattern =
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{9,}$';

                  final regExp = RegExp(pattern);

                  if (!regExp.hasMatch(value)) {
                    return 'Password must be more than 8 characters '
                        'and include upper, lower, number & special char';
                  }

                  return null;
                },

                onSaved: (value) {
                  accountPassword = value;
                },
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  onPressed: () {
                    final form = _formKey.currentState!;

                    // First validate
                    if (!form.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter correct information'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      return;
                    }

                    // IMPORTANT:
                    // This calls all onSaved() callbacks.
                    form.save();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultsPage(
                          accountType: selectedAccountType!,
                          accountNumber: accountNumber!,
                          accountPassword: accountPassword!,
                        ),
                      ),
                    );
                  },

                  child: const Text('Submit'),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

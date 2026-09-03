import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  final String mealId;
  const MealDetailScreen({Key? key, required this.mealId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meal Details')),
      body: Center(child: Text('Loading details for $mealId...')),
    );
  }
}

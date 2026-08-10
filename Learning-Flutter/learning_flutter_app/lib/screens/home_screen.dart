import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../data/topics_registry.dart';
import 'category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Learning Logs')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: Category.values.map((category) {
          final count = topics.where((t) => t.category == category).length;
          return Card(
            child: ListTile(
              title: Text(category.name),
              subtitle: Text('$count topics'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryScreen(category: category),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

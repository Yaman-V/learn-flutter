import 'package:flutter/material.dart';
import 'package:learning_flutter_app/data/topics_registry.dart';
import 'package:learning_flutter_app/models/topic.dart';

class CategoryScreen extends StatelessWidget {
  final Category category;
  const CategoryScreen({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    final items = topics.where((t) => t.category == category).toList();
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: ListView(
        children: items
            .map(
              (t) => ListTile(
                title: Text(t.title),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: t.builder),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

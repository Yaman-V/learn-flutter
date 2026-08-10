import 'package:flutter/material.dart';

enum Category { classes, assignments, miniProjects }

class Topic {
  final String id;
  final String title;
  final Category category;
  final WidgetBuilder builder;

  // Example class_0 , Animations , classes , (context) => const Class07Animation()
  const Topic({
    required this.id,
    required this.title,
    required this.category,
    required this.builder,
  });
}

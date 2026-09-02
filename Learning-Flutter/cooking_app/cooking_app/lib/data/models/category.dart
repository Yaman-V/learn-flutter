class MealCategory {
  final String name;

  MealCategory({required this.name});

  factory MealCategory.fromJson(Map<String, dynamic> json) {
    return MealCategory(name: json['strCategory'] ?? '');
  }
}

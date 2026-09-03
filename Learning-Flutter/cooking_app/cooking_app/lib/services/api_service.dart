import 'dart:convert';
import 'package:cooking_app/data/models/category.dart';
import 'package:cooking_app/data/models/meal.dart';
import 'package:cooking_app/data/models/meal_detail.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search.php?s=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return [];
      return (data['meals'] as List)
          .map((json) => Meal.fromJson(json))
          .toList();
    }
    throw Exception('Failed to load meals');
  }

  Future<List<MealCategory>> getCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/list.php?c=list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return [];
      return (data['meals'] as List)
          .map((json) => MealCategory.fromJson(json))
          .toList();
    }
    throw Exception('Failed to load categories');
  }

  Future<List<Meal>> filterByCategory(String category) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/filter.php?c=$category'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return [];
      return (data['meals'] as List)
          .map((json) => Meal.fromJson(json))
          .toList();
    }
    throw Exception('Failed to filter meals');
  }

  Future<MealDetail?> getMealDetails(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return null;
      return MealDetail.fromJson(data['meals'][0]);
    }
    throw Exception('Failed to load meal details');
  }
}

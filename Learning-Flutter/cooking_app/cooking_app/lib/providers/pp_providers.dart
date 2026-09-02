import 'package:cooking_app/data/models/meal.dart';
import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setTab(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class FavoritesProvider with ChangeNotifier {
  final List<Meal> _favorites = [];
  List<Meal> get favorites => _favorites;

  void toggleFavorite(Meal meal) {
    final index = _favorites.indexWhere((m) => m.id == meal.id);
    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(meal);
    }
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favorites.any((m) => m.id == id);
  }
}

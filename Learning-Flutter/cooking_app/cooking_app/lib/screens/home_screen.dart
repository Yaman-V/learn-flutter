import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/category.dart';
import '../data/models/meal.dart';
import '../providers/app_providers.dart';
import '../services/api_service.dart';
import '../utils/app_colors.dart';
import '../widgets/category_chip.dart';
import '../widgets/meal_grid_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();

  List<MealCategory> _categories = [];
  List<Meal> _meals = [];
  String _selectedCategory = 'All';
  bool _isLoadingMeals = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      final cats = await _apiService.getCategories();
      setState(() {
        _categories = [MealCategory(name: 'All'), ...cats];
      });
      _fetchMealsForCategory('All');
    } catch (e) {
      // Handle error gracefully in production
      setState(() => _isLoadingMeals = false);
    }
  }

  Future<void> _fetchMealsForCategory(String category) async {
    setState(() {
      _isLoadingMeals = true;
      _selectedCategory = category;
    });

    try {
      List<Meal> fetchedMeals;
      if (category == 'All') {
        // Fetch default meals using a generic search
        fetchedMeals = await _apiService.searchMeals('');
      } else {
        fetchedMeals = await _apiService.filterByCategory(category);
      }
      setState(() {
        _meals = fetchedMeals;
        _isLoadingMeals = false;
      });
    } catch (e) {
      setState(() => _isLoadingMeals = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Meal Explorer',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'What are you craving?',
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // Mock Search Bar
            GestureDetector(
              onTap: () {
                context.read<NavigationProvider>().setTab(
                  1,
                ); // Jump to Search Tab
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey.shade400),
                    const SizedBox(width: 12),
                    Text(
                      'Search meals',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Categories List
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = category.name == _selectedCategory;
                  return CategoryChip(
                    label: category.name,
                    isSelected: isSelected,
                    icon: isSelected ? Icons.grid_view : null,
                    onTap: () => _fetchMealsForCategory(category.name),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Meals Grid
            Expanded(
              child: _isLoadingMeals
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.8,
                          ),
                      itemCount: _meals.length,
                      itemBuilder: (context, index) =>
                          MealGridCard(meal: _meals[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

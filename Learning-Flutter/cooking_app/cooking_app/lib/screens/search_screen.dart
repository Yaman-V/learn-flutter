import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/category.dart';
import '../data/models/meal.dart';
import '../providers/app_providers.dart';
import '../services/api_service.dart';
import '../utils/app_colors.dart';
import '../widgets/category_chip.dart';
import '../widgets/meal_list_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  List<Meal> _searchResults = [];
  bool _isIdle = true;
  bool _isLoading = false;

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _isIdle = true;
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isIdle = false;
      _isLoading = true;
    });

    try {
      final results = await _apiService.searchMeals(query);
      setState(() => _searchResults = results);

      if (results.isEmpty && mounted) {
        _showNoResultsDialog();
      }
    } catch (e) {
      _searchResults = [];
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showNoResultsDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('No results found'),
        content: const Text(
          'Try adjusting your search or filtering by a different category.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _openFilterBottomSheet() async {
    final categories = await _apiService.getCategories();

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => _FilterBottomSheet(
        categories: categories,
        onCategorySelected: (categoryName) {
          Navigator.pop(ctx);
          _searchController.clear();
          _filterByCategory(categoryName);
        },
      ),
    );
  }

  Future<void> _filterByCategory(String category) async {
    setState(() {
      _isIdle = false;
      _isLoading = true;
    });

    try {
      final results = await _apiService.filterByCategory(category);
      setState(() => _searchResults = results);
    } catch (e) {
      _searchResults = [];
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.read<NavigationProvider>().setTab(
                    0,
                  ), // Back to Home
                ),
                const Text(
                  'Search',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Search & Filter Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: _performSearch,
                    decoration: InputDecoration(
                      hintText: 'Search meals',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                _performSearch('');
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    onChanged: (val) => setState(() {}), // Update suffix icon
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune, color: AppColors.primary),
                    onPressed: _openFilterBottomSheet,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Results State Handling
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : _isIdle
                  ? const Center(
                      child: Text(
                        'Type to search or use the filter',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    )
                  : _searchResults.isEmpty
                  ? const Center(child: Text('No results.'))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Search results',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) =>
                                MealListCard(meal: _searchResults[index]),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// Private widget specific to the Search Screen
class _FilterBottomSheet extends StatelessWidget {
  final List<MealCategory> categories;
  final Function(String) onCategorySelected;

  const _FilterBottomSheet({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Filter by category',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryChip(
                  label: categories[index].name,
                  isSelected: false,
                  onTap: () => onCategorySelected(categories[index].name),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.pop(
                context,
              ), // Dismiss action if they change their mind
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

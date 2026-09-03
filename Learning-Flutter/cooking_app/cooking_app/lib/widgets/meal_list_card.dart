import 'package:cooking_app/data/models/meal.dart';
import 'package:cooking_app/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/meal_detail_screen.dart';
import '../utils/app_colors.dart';

class MealListCard extends StatelessWidget {
  final Meal meal;

  const MealListCard({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.watch<FavoritesProvider>();
    final isFav = favoritesProvider.isFavorite(meal.id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MealDetailScreen(mealId: meal.id)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                meal.thumbnail,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (meal.area != null && meal.area!.isNotEmpty)
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          meal.area!,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
              color: isFav ? AppColors.primary : AppColors.textSecondary,
              onPressed: () =>
                  context.read<FavoritesProvider>().toggleFavorite(meal),
            ),
          ],
        ),
      ),
    );
  }
}

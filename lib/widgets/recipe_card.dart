import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + Favorite
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      recipe.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Description
              Text(
                recipe.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black87),
              ),

              const SizedBox(height: 8),

              // Ingredients preview
              if (recipe.ingredients.isNotEmpty) ...[
                const Text(
                  "Ingredients:",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  recipe.ingredients.take(2).join(", ") +
                      (recipe.ingredients.length > 2 ? "..." : ""),
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 8),
              ],

              // Steps preview
              if (recipe.steps.isNotEmpty) ...[
                const Text(
                  "Steps:",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  recipe.steps.take(1).join(", ") +
                      (recipe.steps.length > 1 ? "..." : ""),
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

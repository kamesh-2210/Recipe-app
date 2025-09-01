import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Recipe> favorites;
  final void Function(Recipe) onToggleFavorite;

  const FavoritesScreen({
    super.key,
    required this.favorites,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorites yet!"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final r = favorites[index];
                return RecipeCard(
                  recipe: r,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: r,
                    );
                  },
                );
              },
            ),
    );
  }
}

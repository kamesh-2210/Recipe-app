import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Recipe> recipes;
  final void Function(Recipe) onToggleFavorite;

  const HomeScreen({
    super.key,
    required this.recipes,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    // Separate recipes
    final vegRecipes = recipes.where((r) => r.category == "Veg").toList();
    final nonVegRecipes = recipes.where((r) => r.category == "Non-Veg").toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/Recipelogo.png', height: 30),
            const SizedBox(width: 10),
            const Text("Recipe Book"),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Favorites',
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: recipes.isEmpty
          ? const Center(child: Text('No recipes yet. Tap + to add one.'))
          : ListView(
              padding: const EdgeInsets.all(8),
              children: [
                // Veg section
                if (vegRecipes.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "🥦 Veg Recipes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...vegRecipes.map(
                    (recipe) => RecipeCard(
                      recipe: recipe,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: recipe,
                        );
                      },
                    ),
                  ),
                ],

                // Non-Veg section
                if (nonVegRecipes.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "🍗 Non-Veg Recipes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...nonVegRecipes.map(
                    (recipe) => RecipeCard(
                      recipe: recipe,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: recipe,
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/Recipelogo.png', height: 80),
                  const SizedBox(height: 10),
                  const Text(
                    "Recipe Book",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text("Favorites"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/favorites');
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  final void Function(Recipe) onToggleFavorite;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
    required this.onToggleFavorite,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late Recipe recipe;

  @override
  void initState() {
    super.initState();
    // Make a copy to allow toggling
    recipe = widget.recipe;
  }

  void _toggleFavorite() {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
    });
    widget.onToggleFavorite(recipe);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          recipe.isFavorite ? 'Added to favorites' : 'Removed from favorites',
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildList(List<String> items) {
    return ListView.separated(
      itemCount: items.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(items[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('assets/images/Book.png', height: 120)),
            const SizedBox(height: 20),

            // Category
            Text(
              'Category: ${recipe.category}',
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green),
            ),
            const SizedBox(height: 10),

            // Description
            Text(
              recipe.description,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // Ingredients
            _buildSectionTitle('Ingredients'),
            _buildList(recipe.ingredients),

            const SizedBox(height: 20),

            // Steps
            _buildSectionTitle('Steps'),
            _buildList(recipe.steps),

            const SizedBox(height: 30),

            Center(
              child: FilledButton.icon(
                onPressed: _toggleFavorite,
                icon: Icon(
                  recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                label: Text(
                  recipe.isFavorite ? "Unmark Favorite" : "Mark Favorite",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

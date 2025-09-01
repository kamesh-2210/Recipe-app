// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_recipe_screen.dart';
import 'screens/recipe_detail_screen.dart';
import 'screens/favorites_screen.dart';
import 'models/recipe.dart';

void main() {
  runApp(const RecipeBookApp());
}

class RecipeBookApp extends StatefulWidget {
  const RecipeBookApp({super.key});

  @override
  _RecipeBookAppState createState() => _RecipeBookAppState();
}

class _RecipeBookAppState extends State<RecipeBookApp> {
  List<Recipe> recipes = [
    Recipe(
      title: "Pizza",
      description: "Cheesy delight",
      ingredients: [
        "2 cups all-purpose flour",
        "1 cup mozzarella cheese",
        "1/2 cup pizza sauce",
        "1 tsp olive oil",
        "Salt to taste"
      ],
      steps: [
        "Prepare the dough and let it rise.",
        "Roll the dough into a circle.",
        "Spread pizza sauce evenly.",
        "Add cheese and toppings.",
        "Bake for 15–20 minutes at 200°C."
      ],
      category: 'Veg',
    ),
    Recipe(
      title: "Pasta",
      description: "Italian special",
      ingredients: [
        "200g pasta",
        "1 cup tomato sauce",
        "2 tbsp olive oil",
        "1 onion, chopped",
        "Grated parmesan"
      ],
      steps: [
        "Boil pasta until al dente.",
        "Sauté onions in olive oil.",
        "Add tomato sauce and simmer.",
        "Mix pasta with sauce.",
        "Serve with parmesan."
      ],
      category: 'Veg',
    ),
    Recipe(
      title: "Burger",
      description: "Juicy beef burger",
      ingredients: [
        "2 burger buns",
        "200g ground beef patty",
        "Lettuce, tomato slices",
        "1 cheese slice",
        "Mayonnaise"
      ],
      steps: [
        "Grill the beef patty.",
        "Toast the buns lightly.",
        "Spread mayonnaise on buns.",
        "Assemble patty, lettuce, tomato, and cheese.",
        "Serve hot."
      ],
      category: 'Non-Veg',
    ),
    Recipe(
      title: "Sushi",
      description: "Fresh Japanese sushi",
      ingredients: [
        "2 cups sushi rice",
        "4 nori sheets",
        "100g raw salmon",
        "1 cucumber, sliced",
        "Soy sauce & wasabi"
      ],
      steps: [
        "Cook sushi rice and season with vinegar.",
        "Place nori sheet on bamboo mat.",
        "Spread rice evenly on nori.",
        "Add salmon and cucumber.",
        "Roll tightly and cut into pieces."
      ],
      category: 'Non-Veg',
    ),
    Recipe(
      title: "Tacos",
      description: "Mexican street food",
      ingredients: [
        "4 taco shells",
        "200g chicken/beef filling",
        "Lettuce, tomato, onion",
        "Cheese, salsa",
        "Sour cream"
      ],
      steps: [
        "Cook chicken/beef with spices.",
        "Warm the taco shells.",
        "Add filling into shells.",
        "Top with lettuce, tomato, cheese, and salsa.",
        "Serve with sour cream."
      ],
      category: 'Non-Veg',
    ),
    Recipe(
      title: "Salad",
      description: "Healthy green salad",
      ingredients: [
        "1 cucumber",
        "1 tomato",
        "1 carrot",
        "Lettuce leaves",
        "Salt, lemon juice, olive oil"
      ],
      steps: [
        "Chop all vegetables.",
        "Mix in a large bowl.",
        "Add salt, olive oil, and lemon juice.",
        "Toss well and serve fresh."
      ],
      category: 'Veg',
    ),
    Recipe(
      title: "Chocolate Cake",
      description: "Decadent dessert",
      ingredients: [
        "1 cup all-purpose flour",
        "1/2 cup cocoa powder",
        "1 cup sugar",
        "2 eggs",
        "1/2 cup butter",
        "1 tsp baking powder"
      ],
      steps: [
        "Mix flour, cocoa, and baking powder.",
        "Beat eggs, butter, and sugar.",
        "Combine wet and dry ingredients.",
        "Pour into cake pan.",
        "Bake at 180°C for 30 minutes."
      ],
      category: 'Veg',
    ),
  ];

  List<Recipe> favorites = [];

  void _toggleFavorite(Recipe recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
      favorites = recipes.where((r) => r.isFavorite).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(
              recipes: recipes,
              onToggleFavorite: _toggleFavorite,
            ),
        '/add': (context) => AddRecipeScreen(
              onAddRecipe: (recipe) {
                setState(() {
                  recipes = [...recipes, recipe];
                  favorites = recipes.where((r) => r.isFavorite).toList();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added: ${recipe.title}')),
                );
              },
            ),
        '/favorites': (context) => FavoritesScreen(
              favorites: favorites,
              onToggleFavorite: _toggleFavorite,
            ),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final recipe = settings.arguments as Recipe;
          return MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(
              recipe: recipe,
              onToggleFavorite: _toggleFavorite,
            ),
          );
        }
        return null;
      },
    );
  }
}

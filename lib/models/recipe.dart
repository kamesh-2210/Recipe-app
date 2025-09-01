class Recipe {
  String title;
  String description;
  List<String> ingredients;
  List<String> steps;
  String category; // 'Veg' or 'Non-Veg'
  bool isFavorite;

  Recipe({
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.category,
    this.isFavorite = false,
  });
}

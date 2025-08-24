class IngredientCreateDto {
  final num? quantity;
  final String? unit;
  final String description;
  IngredientCreateDto({this.quantity, this.unit, required this.description});

  Map<String, dynamic> toJson() =>
      {"quantity": quantity, "unit": unit, "description": description};
}

class RecipeCreateDto {
  final String title;
  final String sourceUrl;
  final String imageUrl;
  final String publisher;
  final int cookingTime;
  final int servings;
  final List<IngredientCreateDto> ingredients;

  RecipeCreateDto({
    required this.title,
    required this.sourceUrl,
    required this.imageUrl,
    required this.publisher,
    required this.cookingTime,
    required this.servings,
    required this.ingredients,
  });

  Map<String, dynamic> toJson() => {
        "recipe": {
          "title": title,
          "source_url": sourceUrl,
          "image_url": imageUrl,
          "publisher": publisher,
          "cooking_time": cookingTime,
          "servings": servings,
          "ingredients": ingredients.map((e) => e.toJson()).toList(),
        }
      };
}

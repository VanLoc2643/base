class RecipeDetailDto {
  final String id;
  final String title;
  final String imageUrl;
  final String publisher;
  final int cookingTime;
  final int servings;
  final List<IngredientDto> ingredients;

  RecipeDetailDto({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.publisher,
    required this.cookingTime,
    required this.servings,
    required this.ingredients,
  });

  factory RecipeDetailDto.fromJson(Map<String, dynamic> json) {
    final ing = (json['ingredients'] as List)
        .map((i) => IngredientDto.fromJson(i as Map<String, dynamic>))
        .toList();

    return RecipeDetailDto(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String,
      publisher: json['publisher'] as String,
      cookingTime: json['cooking_time'] as int,
      servings: json['servings'] as int,
      ingredients: ing,
    );
  }
}

class IngredientDto {
  final num? quantity;
  final String? unit;
  final String description;

  IngredientDto({this.quantity, this.unit, required this.description});

  factory IngredientDto.fromJson(Map<String, dynamic> json) => IngredientDto(
        quantity: json['quantity'] as num?,
        unit: json['unit'] as String?,
        description: json['description'] as String,
      );
}

import 'package:app_demo/features/recipes/data/models/recipe_dto.dart';
import 'package:app_demo/features/recipes/domain/entities/recipe.dart';

extension RecipeMapper on RecipeDto {
  Recipe toEntity() {
    return Recipe(
        id: id,
        title: title,
        imageUrl: imageUrl,
        publisher: publisher,
        cookingTime: cookingTime);
  }
}

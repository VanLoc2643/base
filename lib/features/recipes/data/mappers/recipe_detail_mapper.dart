import 'package:app_demo/features/home/widgets/bottom_nav_bar_widget.dart';


import '../models/recipe_detail_dto.dart';

extension RecipeDetailMapper on RecipeDetailDto {
  RecipeDetail toEntity() => RecipeDetail(
        id: id,
        title: title,
        imageUrl: imageUrl,
        publisher: publisher,
        cookingTime: cookingTime,
        servings: servings,
        ingredients: ingredients.map((i) => i.toEntity()).toList(),
      );
}

extension IngredientMapper on IngredientDto {
  Ingredient toEntity() =>
      Ingredient(quantity: quantity, unit: unit, description: description);
}

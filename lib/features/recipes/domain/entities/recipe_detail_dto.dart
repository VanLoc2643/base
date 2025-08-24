import 'package:equatable/equatable.dart';

class RecipeDetail extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final String publisher;
  final int cookingTime;
  final int servings;
  final List<Ingredient> ingredients;

  const RecipeDetail({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.publisher,
    required this.cookingTime,
    required this.servings,
    required this.ingredients,
  });

  @override
  List<Object?> get props => [id, title, imageUrl, publisher, cookingTime, servings, ingredients];
}

class Ingredient extends Equatable {
  final num? quantity;
  final String? unit;
  final String description;

  const Ingredient({this.quantity, this.unit, required this.description});

  @override
  List<Object?> get props => [quantity, unit, description];
}

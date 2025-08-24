// create_recipe_event.dart

import 'package:app_demo/features/recipes/data/models/recipe_create_dto.dart';
import 'package:equatable/equatable.dart';

abstract class CreateRecipeEvent extends Equatable {
  const CreateRecipeEvent();
  @override
  List<Object?> get props => [];
}

class CreateRecipeSubmitted extends CreateRecipeEvent {
  final RecipeCreateDto dto;
  const CreateRecipeSubmitted(this.dto);
  @override
  List<Object?> get props => [dto];
}

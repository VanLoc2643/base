import 'package:app_demo/features/home/widgets/bottom_nav_bar_widget.dart';
import 'package:app_demo/features/recipes/data/models/recipe_create_dto.dart';

import '../entities/recipe.dart';

abstract class IRecipeRepository {
  Future<List<Recipe>> search(String query);
  Future<RecipeDetail> getDetail(String id);
  Future<RecipeDetail> create(RecipeCreateDto dto);
}

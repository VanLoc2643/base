import 'package:app_demo/features/recipes/domain/entities/recipe.dart';
import 'package:app_demo/features/recipes/domain/repositories/i_recipe_repository.dart';

class SearchRecipesUsecase {
  final IRecipeRepository _repo;

  SearchRecipesUsecase(this._repo);

   Future<List<Recipe>> call(String query) async {
    final q = query.trim();
    if(q.isEmpty) {
      return [];
    }
    return _repo.search(q);
   }
}
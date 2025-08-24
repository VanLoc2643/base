
import 'package:app_demo/features/home/widgets/bottom_nav_bar_widget.dart';
import 'package:app_demo/features/recipes/domain/repositories/i_recipe_repository.dart';

class GetRecipeDetailUseCase {
  final IRecipeRepository _repo;
  GetRecipeDetailUseCase(this._repo);

  Future<RecipeDetail> call(String id) => _repo.getDetail(id);
}

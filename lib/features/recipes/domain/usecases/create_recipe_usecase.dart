// domain/usecases/create_recipe_usecase.dart
import 'package:app_demo/features/home/widgets/bottom_nav_bar_widget.dart';
import 'package:app_demo/features/recipes/data/models/recipe_create_dto.dart';
import 'package:app_demo/features/recipes/domain/repositories/i_recipe_repository.dart';

class CreateRecipeUseCase {
  final IRecipeRepository _repo;
  CreateRecipeUseCase(this._repo);

  Future<RecipeDetail> call(RecipeCreateDto dto) => _repo.create(dto);
}

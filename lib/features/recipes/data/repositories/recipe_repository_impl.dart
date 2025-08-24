import 'package:app_demo/features/home/widgets/bottom_nav_bar_widget.dart';
import 'package:app_demo/features/recipes/data/mappers/recipe_detail_mapper.dart';
import 'package:app_demo/features/recipes/data/models/recipe_create_dto.dart';

import '../../domain/entities/recipe.dart';
import '../../domain/repositories/i_recipe_repository.dart';
import '../datasources/recipe_remote_ds.dart';
import '../mappers/recipe_mapper.dart';

class RecipeRepositoryImpl implements IRecipeRepository {
  final RecipeRemoteDataSource _ds;
  RecipeRepositoryImpl(this._ds);

  @override
  Future<List<Recipe>> search(String query) async {
    final dtos = await _ds.search(query);
    return dtos.map((e) => e.toEntity()).toList();
  }

  @override
  Future<RecipeDetail> getDetail(String id) async {
    final dto = await _ds.getDetail(id);
    return dto.toEntity();
  }

  @override
  Future<RecipeDetail> create(RecipeCreateDto dto) async {
    final created = await _ds.create(dto);
    return created.toEntity(); // map sang RecipeDetail entity
  }
}

import 'package:app_demo/features/recipes/domain/usecases/create_recipe_usecase.dart';
import 'package:app_demo/features/recipes/domain/usecases/get_recipe_detail_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../features/recipes/data/datasources/recipe_remote_ds.dart';
import '../../features/recipes/data/repositories/recipe_repository_impl.dart';
import '../../features/recipes/domain/repositories/i_recipe_repository.dart';
import '../../features/recipes/domain/usecases/search_recipes_usecase.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton<Dio>(
      () => buildDio(baseUrl: 'https://forkify-api.jonas.io/api/v2'));

  sl.registerLazySingleton<RecipeRemoteDataSource>(() => RecipeRemoteDataSource(
      sl<Dio>(),
      apiKey: '10aec8ab-cdbf-43a2-a95c-2170ee0a160c'));

  sl.registerLazySingleton<IRecipeRepository>(
      () => RecipeRepositoryImpl(sl<RecipeRemoteDataSource>()));

  sl.registerLazySingleton(() => SearchRecipesUsecase(sl<IRecipeRepository>()));

  sl.registerLazySingleton(
      () => GetRecipeDetailUseCase(sl<IRecipeRepository>()));

  sl.registerLazySingleton(() => CreateRecipeUseCase(sl<IRecipeRepository>()));
}

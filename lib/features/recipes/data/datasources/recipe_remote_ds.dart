import 'package:app_demo/features/recipes/data/models/recipe_create_dto.dart';
import 'package:app_demo/features/recipes/data/models/recipe_detail_dto.dart';
import 'package:app_demo/features/recipes/data/models/recipe_dto.dart';
import 'package:dio/dio.dart';

class RecipeRemoteDataSource {
  final Dio _dio;
  final String apiKey;
  RecipeRemoteDataSource(this._dio, {required this.apiKey});

  Future<List<RecipeDto>> search(String query) async {
    final res = await _dio.get('/recipes', queryParameters: {'search': query});
    final list =
        (res.data['data']['recipes'] as List).cast<Map<String, dynamic>>();
    return list.map((m) => RecipeDto.fromJson(m)).toList();
  }

  Future<RecipeDetailDto> getDetail(String id) async {
    final res = await _dio.get('/recipes/$id');
    final m = res.data['data']['recipe'] as Map<String, dynamic>;
    return RecipeDetailDto.fromJson(m);
  }

  Future<RecipeDetailDto> create(RecipeCreateDto body) async {
    final res = await _dio.post(
      '/recipes',
      queryParameters: {"key": apiKey},
      data: body.toJson(),
    );
    final m = res.data['data']['recipe'] as Map<String, dynamic>;
    return RecipeDetailDto.fromJson(m);
  }
}

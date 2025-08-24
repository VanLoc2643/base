// ...existing code...
import 'package:app_demo/features/recipes/domain/entities/recipe.dart';
import 'package:equatable/equatable.dart';

class RecipeState extends Equatable {
  final bool loading;       // initial loading for query
  final bool loadingMore;   // loading next page
  final List<Recipe> items;
  final bool hasReachedMax;
  final String? error;
  final String success;

  const RecipeState({
    required this.loading,
    required this.items,
    this.loadingMore = false,
    this.hasReachedMax = false,
    this.error,
    this.success = "",
  });

  const RecipeState.initial() : this(loading: false, items: const []);
  const RecipeState.loading() : this(loading: true, items: const []);
  const RecipeState.failure(String msg) : this(loading: false, items: const [], error: msg);
  const RecipeState.success(List<Recipe> items, {bool hasReachedMax = false})
      : this(loading: false, items: items, hasReachedMax: hasReachedMax);

  RecipeState copyWith({
    bool? loading,
    bool? loadingMore,
    List<Recipe>? items,
    bool? hasReachedMax,
    String? error,
    String? success,
  }) {
    return RecipeState(
      loading: loading ?? this.loading,
      items: items ?? this.items,
      loadingMore: loadingMore ?? this.loadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [loading, loadingMore, items, hasReachedMax, error, success];
}
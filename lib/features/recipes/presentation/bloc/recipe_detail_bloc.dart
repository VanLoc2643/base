import 'package:app_demo/features/recipes/domain/usecases/get_recipe_detail_usecase.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_detail_event.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_detail_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final GetRecipeDetailUseCase _getDetail;

  RecipeDetailBloc(this._getDetail) : super(const RecipeDetailState.initial()) {
    on<RecipeDetailRequested>(_onRequested);
  }

  Future<void> _onRequested(
      RecipeDetailRequested e, Emitter<RecipeDetailState> emit) async {
    emit(const RecipeDetailState.loading());
    try {
      final recipe = await _getDetail(e.id);
      emit(RecipeDetailState.success(recipe));
    } catch (err) {
      emit(RecipeDetailState.failure(err.toString()));
    }
  }
}

import 'package:app_demo/features/recipes/presentation/bloc/create/create_recipe_event.dart';
import 'package:app_demo/features/recipes/presentation/bloc/create/create_recipe_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/create_recipe_usecase.dart';
import '../../../data/models/recipe_create_dto.dart';

class CreateRecipeBloc extends Bloc<CreateRecipeEvent, CreateRecipeState> {
  final CreateRecipeUseCase _create;

  CreateRecipeBloc(this._create) : super(const CreateRecipeState.initial()) {
    on<CreateRecipeSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    CreateRecipeSubmitted e,
    Emitter<CreateRecipeState> emit,
  ) async {
    // validate đơn giản (title, urls, ingredients…)
    if (e.dto.title.trim().isEmpty ||
        e.dto.sourceUrl.trim().isEmpty ||
        e.dto.imageUrl.trim().isEmpty ||
        e.dto.ingredients.isEmpty) {
      emit(const CreateRecipeState.failure('Missing required fields'));
      return;
    }

    emit(const CreateRecipeState.creating());
    try {
      final result = await _create(e.dto);
      emit(CreateRecipeState.success(result));
    } catch (err) {
      emit(CreateRecipeState.failure(err.toString()));
    }
  }
}

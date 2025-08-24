import 'dart:async';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_event.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../recipes/domain/entities/recipe.dart';
import '../../../recipes/domain/usecases/search_recipes_usecase.dart';
import 'package:stream_transform/stream_transform.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final SearchRecipesUsecase _search;
  static const _debounce = Duration(milliseconds: 400);

  RecipeBloc(this._search) : super(const RecipeState.initial()) {
    // Debounce QueryChanged để tiết kiệm quota API
    on<QueryChanged>(_onQueryChanged, transformer: _debounceEvent());
    on<SearchSubmitted>(_onSearchSubmitted);
  }

  EventTransformer<QueryChanged> _debounceEvent() {
    return (events, mapper) => events.debounce(_debounce).asyncExpand(mapper);
  }

  Future<void> _onQueryChanged(
      QueryChanged e, Emitter<RecipeState> emit) async {
    await _doSearch(e.query, emit);
  }

  Future<void> _onSearchSubmitted(
      SearchSubmitted e, Emitter<RecipeState> emit) async {
    await _doSearch(e.query, emit);
  }


  Future<void> _doSearch(String query, Emitter<RecipeState> emit) async {
    final q = query.trim();
    print('RecipeBloc: _doSearch query="$q"'); // <-- debug
    if (q.isEmpty) {
      emit(const RecipeState.initial());
      return;
    }
    emit(const RecipeState.loading());
    try {
      final items = await _search(q);
      print('RecipeBloc: _doSearch found ${items.length} items'); // <-- debug
      emit(RecipeState.success(items));
    } catch (err) {
      emit(RecipeState.failure(err.toString()));
    }
  }

  

  
  
}



import 'package:equatable/equatable.dart';


abstract class RecipeDetailEvent extends Equatable {
  const RecipeDetailEvent();
  @override
  List<Object?> get props => [];
}



class RecipeDetailRequested extends RecipeDetailEvent {
  final String id;
  const RecipeDetailRequested(this.id);
  @override
  List<Object?> get props => [id];
}

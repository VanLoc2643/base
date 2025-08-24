
import 'package:app_demo/features/home/widgets/bottom_nav_bar_widget.dart';
import 'package:equatable/equatable.dart';

class RecipeDetailState extends Equatable {
  final bool loading;
  final RecipeDetail? data;
  final String? error;

  const RecipeDetailState({required this.loading, this.data, this.error});

  const RecipeDetailState.initial() : this(loading: false);
  const RecipeDetailState.loading() : this(loading: true);
  const RecipeDetailState.success(RecipeDetail d) : this(loading: false, data: d);
  const RecipeDetailState.failure(String msg) : this(loading: false, error: msg);

  @override
  List<Object?> get props => [loading, data, error];
}

import 'package:app_demo/features/home/widgets/bottom_nav_bar_widget.dart';
import 'package:equatable/equatable.dart';

class CreateRecipeState extends Equatable {
  final bool creating;
  final RecipeDetail? created;
  final String? error;

  const CreateRecipeState({required this.creating, this.created, this.error});

  const CreateRecipeState.initial() : this(creating: false);
  const CreateRecipeState.creating() : this(creating: true);
  const CreateRecipeState.success(RecipeDetail r)
      : this(creating: false, created: r);
  const CreateRecipeState.failure(String msg)
      : this(creating: false, error: msg);

  @override
  List<Object?> get props => [creating, created, error];
}

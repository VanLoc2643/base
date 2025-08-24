import 'package:equatable/equatable.dart';


// ...existing code...
abstract class RecipeEvent extends Equatable{
  const RecipeEvent();
  @override
  List<Object?> get props => [];
}

class QueryChanged extends RecipeEvent {
  final String query;
  const QueryChanged(this.query);
  @override
  List<Object?> get props => [query];
}

class SearchSubmitted extends RecipeEvent {
  final String query;
  const SearchSubmitted(this.query);
  @override
  List<Object?> get props => [query];
}

// new: load next page
class LoadMore extends RecipeEvent {
  const LoadMore();
}
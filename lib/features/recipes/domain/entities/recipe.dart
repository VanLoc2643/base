import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final String publisher;
  final int cookingTime;

  Recipe(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.publisher,
      required this.cookingTime});

  @override
  List<Object?> get props => [id, title, imageUrl, cookingTime, publisher];
}

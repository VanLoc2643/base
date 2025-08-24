import 'package:app_demo/app/di.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_detail_event.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_recipe_detail_usecase.dart';
import '../bloc/recipe_detail_bloc.dart';

class RecipeDetailPage extends StatelessWidget {
  final String id;
  const RecipeDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecipeDetailBloc(sl<GetRecipeDetailUseCase>())
        ..add(RecipeDetailRequested(id)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Recipe Detail')),
        body: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
          builder: (context, state) {
            if (state.loading)
              return const Center(child: CircularProgressIndicator());
            if (state.error != null)
              return Center(child: Text('Error: ${state.error}'));
            final r = state.data;
            if (r == null) return const SizedBox.shrink();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(r.imageUrl, fit: BoxFit.cover),
                  const SizedBox(height: 12),
                  Text(r.title,
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text('By ${r.publisher}'),
                  Text('${r.cookingTime} min | Servings: ${r.servings}'),
                  const Divider(),
                  const Text('Ingredients:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ...r.ingredients.map((i) => Text(
                      '- ${i.quantity ?? ''} ${i.unit ?? ''} ${i.description}')),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:app_demo/app/di.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_event.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_state.dart';
import 'package:app_demo/features/recipes/presentation/pages/create_recipe_page.dart';
import 'package:app_demo/features/recipes/presentation/pages/recipe_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/search_recipes_usecase.dart';
import '../bloc/recipe_bloc.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final _controller = TextEditingController(text: 'pizza');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecipeBloc(sl<SearchRecipesUsecase>())
        ..add(SearchSubmitted(_controller.text)),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              'Shoppe Foods 🍕',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => context
                    .read<RecipeBloc>()
                    .add(SearchSubmitted(_controller.text)),
                icon: const Icon(Icons.search_rounded),
                tooltip: 'Search',
              ),
              IconButton(
                onPressed: () async {
                  final created = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const CreateRecipePage(),
                    ),
                  );
                  if (created != null) {
                    context
                        .read<RecipeBloc>()
                        .add(SearchSubmitted(_controller.text));
                  }
                },
                icon: const Icon(Icons.add_circle_outline),
                tooltip: 'Add Recipe',
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(16),
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.search,
                    onChanged: (q) =>
                        context.read<RecipeBloc>().add(QueryChanged(q)),
                    onSubmitted: (q) =>
                        context.read<RecipeBloc>().add(SearchSubmitted(q)),
                    decoration: InputDecoration(
                      hintText: 'Search recipes (e.g. pizza)',
                      prefixIcon: const Icon(Icons.fastfood_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<RecipeBloc, RecipeState>(
                  builder: (context, state) {
                    if (state.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.error != null) {
                      return Center(
                        child: Text(
                          '⚠️ Error: ${state.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    if (state.items.isEmpty) {
                      return const Center(child: Text('🍽️ No recipes found'));
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 3 / 4,
                      ),
                      itemCount: state.items.length,
                      itemBuilder: (ctx, i) {
                        final r = state.items[i];
                        return Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(16),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => RecipeDetailPage(id: r.id),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Hero(
                                    tag: "recipe-${r.id}",
                                    child: Image.network(
                                      r.imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Center(
                                              child: Icon(Icons.broken_image)),
                                      loadingBuilder:
                                          (context, child, progress) {
                                        if (progress == null) return child;
                                        return const Center(
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    r.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

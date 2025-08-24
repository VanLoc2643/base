// presentation/create/create_recipe_page.dart
import 'package:app_demo/app/di.dart';
import 'package:app_demo/features/recipes/data/models/recipe_create_dto.dart';
import 'package:app_demo/features/recipes/domain/usecases/create_recipe_usecase.dart';
import 'package:app_demo/features/recipes/presentation/bloc/create/create_recipe_bloc.dart';
import 'package:app_demo/features/recipes/presentation/bloc/create/create_recipe_event.dart';
import 'package:app_demo/features/recipes/presentation/bloc/create/create_recipe_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateRecipePage extends StatefulWidget {
  const CreateRecipePage({super.key});

  @override
  State<CreateRecipePage> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  final _title = TextEditingController();
  final _source = TextEditingController();
  final _image = TextEditingController();
  final _publisher = TextEditingController(text: 'GET');
  final _cooking = TextEditingController(text: '30');
  final _servings = TextEditingController(text: '4');
  final _ingredients = <TextEditingController>[
    TextEditingController(text: '1'),
    TextEditingController(text: 'kg'),
    TextEditingController(text: 'leeks'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateRecipeBloc(sl<CreateRecipeUseCase>()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Recipe')),
        body: BlocConsumer<CreateRecipeBloc, CreateRecipeState>(
          listenWhen: (p, c) => p.created != c.created || p.error != c.error,
          listener: (context, state) {
            if (state.created != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Recipe created!')),
              );
              Navigator.of(context)
                  .pop(state.created); // trả về để list có thể refresh/insert
            }
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            final creating = state.creating;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: AutofillGroup(
                child: Column(
                  children: [
                    TextField(
                        controller: _title,
                        decoration: const InputDecoration(labelText: 'Title')),
                    TextField(
                        controller: _source,
                        decoration:
                            const InputDecoration(labelText: 'Source URL')),
                    TextField(
                        controller: _image,
                        decoration:
                            const InputDecoration(labelText: 'Image URL')),
                    TextField(
                        controller: _publisher,
                        decoration:
                            const InputDecoration(labelText: 'Publisher')),
                    TextField(
                        controller: _cooking,
                        decoration:
                            const InputDecoration(labelText: 'Prep time (min)'),
                        keyboardType: TextInputType.number),
                    TextField(
                        controller: _servings,
                        decoration:
                            const InputDecoration(labelText: 'Servings'),
                        keyboardType: TextInputType.number),
                    const SizedBox(height: 16),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'One ingredient (quantity, unit, description)')),
                    Row(
                      children: [
                        Expanded(
                            child: TextField(
                                controller: _ingredients[0],
                                decoration: const InputDecoration(
                                    hintText: 'Quantity'))),
                        const SizedBox(width: 8),
                        Expanded(
                            child: TextField(
                                controller: _ingredients[1],
                                decoration:
                                    const InputDecoration(hintText: 'Unit'))),
                        const SizedBox(width: 8),
                        Expanded(
                            child: TextField(
                                controller: _ingredients[2],
                                decoration: const InputDecoration(
                                    hintText: 'Description'))),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: creating
                            ? null
                            : () {
                                final dto = RecipeCreateDto(
                                  title: _title.text,
                                  sourceUrl: _source.text,
                                  imageUrl: _image.text,
                                  publisher: _publisher.text,
                                  cookingTime: int.tryParse(_cooking.text) ?? 0,
                                  servings: int.tryParse(_servings.text) ?? 0,
                                  ingredients: [
                                    IngredientCreateDto(
                                      quantity:
                                          num.tryParse(_ingredients[0].text),
                                      unit: _ingredients[1].text.isEmpty
                                          ? null
                                          : _ingredients[1].text,
                                      description: _ingredients[2].text,
                                    ),
                                  ],
                                );
                                context
                                    .read<CreateRecipeBloc>()
                                    .add(CreateRecipeSubmitted(dto));
                              },
                        icon: creating
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.upload),
                        label: Text(creating ? 'Uploading...' : 'Upload'),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

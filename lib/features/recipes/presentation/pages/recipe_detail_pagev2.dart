import 'package:app_demo/app/di.dart';
import 'package:app_demo/core/theme/app_color.dart';
import 'package:app_demo/features/home/widgets/bottom_nav_bar_widget.dart';
import 'package:app_demo/features/recipes/domain/usecases/get_recipe_detail_usecase.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_detail_bloc.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_detail_event.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_detail_state.dart';
import 'package:app_demo/features/recipes/presentation/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetailPagev2 extends StatelessWidget {
  final String id;
  const RecipeDetailPagev2({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => RecipeDetailBloc(sl<GetRecipeDetailUseCase>())
          ..add(RecipeDetailRequested(id)),
        child: Scaffold(body: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
          builder: (context, state) {
            if (state.loading)
              return const Center(child: CircularProgressIndicator());
            if (state.error != null)
              return Center(child: Text('Error: ${state.error}'));
            final r = state.data;
            if (r == null) return const SizedBox.shrink();

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        r.imageUrl, // 🖼️ Replace with your asset
                        width: double.infinity,
                        height: 280,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 40,
                        left: 16,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.close, color: Colors.black),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40,
                        right: 16,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          
                          child:
                              Icon(Icons.favorite_border, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(34)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                r.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Icon(Icons.access_time, size: 16),
                            SizedBox(width: 4),
                            Text('${r.cookingTime} Min'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ...r.ingredients.map((ing) => Text(
                              '${ing.description}',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.sofiaSans(
                                  fontSize: 12, color: AppColors.dark4),
                            )),
                        // 🔽 View More/less section
                        IngredientSection(ingredients: r.ingredients),
                        SizedBox(
                          height: 12,
                        ),
                        _buildIngredients(r.ingredients),
                        SizedBox(
                          height: 42,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: CustomBottomAppBar(
          currentIndex: 0,
          onTabSelected: (index) {
            // Handle tab selection
          },
        )
        )  
        );
  }
}

class IngredientSection extends StatefulWidget {
  final List<Ingredient> ingredients;
  const IngredientSection({super.key, required this.ingredients});

  @override
  State<IngredientSection> createState() => _IngredientSectionState();
}

class _IngredientSectionState extends State<IngredientSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final fullText = widget.ingredients.map((e) => e.description).join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fullText,
          maxLines: isExpanded ? null : 2,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: GoogleFonts.sofiaSans(
            fontSize: 12,
            color: AppColors.dark4,
          ),
        ),
        if (fullText.length > 50) // Hoặc bạn có thể tùy chỉnh logic này
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                isExpanded ? 'View Less' : 'View More',
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
      ],
    );
  }
}

class _IngredientItem extends StatelessWidget {
  final Ingredient ingredient;

  const _IngredientItem({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFF1F1F1),
            child: Icon(Icons.fastfood, color: Colors.orange),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              ingredient.description,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, size: 18),
                onPressed: () {},
              ),
              Text('${ingredient.quantity ?? 1}'),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 18),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildIngredients(List<Ingredient> ingredients) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("Ingredients", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Add All to Cart",
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)),
        ],
      ),
      const SizedBox(height: 8),
      ...ingredients.map((ing) => _IngredientItem(ingredient: ing)).toList(),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF85C6C1), // Tuỳ chỉnh màu nút
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          minimumSize: const Size.fromHeight(48),
        ),
        child: Text(
          "Add To Cart",
          style: GoogleFonts.sofiaSans(
              color: AppColors.light1,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

// ...existing code...
import 'package:app_demo/app/di.dart';
import 'package:app_demo/features/recipes/domain/usecases/search_recipes_usecase.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_event.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_state.dart';
import 'package:app_demo/features/recipes/presentation/pages/recipe_detail_pagev2.dart';
import 'package:app_demo/features/recipes/presentation/widgets/card_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ...existing code...
class RecipeSearchScreen extends StatefulWidget {
  const RecipeSearchScreen({super.key});

  @override
  State<RecipeSearchScreen> createState() => _RecipeSearchScreenState();
}

class _RecipeSearchScreenState extends State<RecipeSearchScreen> {
  final _controller = TextEditingController();
  int _selectedChip = 0;

  final _chips = const ['Breakfast', 'Lunch', 'Dinner'];

  
  @override
  Widget build(BuildContext context) {
    final dark = const Color(0xFF0E2A2F);
    final text = const Color(0xFF153A40);
    final hint = const Color(0xFF9FB0B6);
    final chipBg = const Color(0xFFE9F3F1);
    final primary = const Color(0xFF2AB3B1);

    return BlocProvider(
      create:    (context) => RecipeBloc(sl<SearchRecipesUsecase>())
        ..add(SearchSubmitted("leek")),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<RecipeBloc, RecipeState>(
            builder:(context, state) =>  ListView(
     
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              
              children: [
                // AppBar row
                Row(
                  children: [
                    // IconButton(
                    //   icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    //   onPressed: () => Navigator.maybePop(context),
                    // ),
                    const Spacer(),
                    Text('Search',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: dark,
                        )),
                    const Spacer(),
                    const SizedBox(width: 48), // để cân đối với nút back
                  ],
                ),
                const SizedBox(height: 8),
                  
                // Search box: dispatch QueryChanged (debounced in bloc) and SearchSubmitted on submit
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: hint),
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    filled: true,
                    fillColor: const Color(0xFFF6F8F9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (q) {
                    // gửi QueryChanged (bloc đã debounce)
                    context.read<RecipeBloc>().add(QueryChanged(q));
                  },
                  onSubmitted: (q) {
                    // gửi ngay khi nhấn enter/search
                    context.read<RecipeBloc>().add(SearchSubmitted(q));
                  },
                ),
                  
                const SizedBox(height: 16),
                  
                // Chips
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _chips.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, i) {
                      final selected = _selectedChip == i;
                      return ChoiceChip(
                        label: Text(_chips[i]),
                        selected: selected,
                        onSelected: (_) => setState(() => _selectedChip = i),
                        selectedColor: primary.withOpacity(.18),
                        labelStyle: TextStyle(
                          color: selected ? primary : text.withOpacity(.7),
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor: chipBg,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      );
                    },
                  ),
                ),
                  
                const SizedBox(height: 20),
                   // Popular Recipes
                _SectionHeader(
                  title: 'Popular Recipes',
                  onViewAll: () {},
                ),
                const SizedBox(height: 12),

                // show vertical list (nested inside parent ListView) -> shrinkWrap + never scroll
                if (state.loading && state.items.isEmpty)
                  SizedBox(height: 150, child: const Center(child: CircularProgressIndicator()))
                else if (state.items.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text('No recipes found', style: TextStyle(color: hint)),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      final width = MediaQuery.of(context).size.width - 32; // account for horizontal padding
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RecipeDetailPagev2(id: item.id),
                            ),
                          );
                        },
                        child: PopularRecipeCard(
                          widthCard: width,
                          recipe: item,
                          showIcon: false, // show favorite icon on full-width card
                          // optionally add compact: false if you added that flag
                          onTapFavorite: () {
                            // xử lý favorite nếu cần
                          },
                        ),
                      );
                    },
                  ),
                  
           
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ...existing code...
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const _SectionHeader({
    required this.title,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = const Color(0xFF0F2E33);
    final actionColor = const Color(0xFF2AB3B1);
    return Row(
      children: [
        Text(title,
            style: TextStyle(
              color: titleColor,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            )),
        const Spacer(),
        GestureDetector(
          onTap: onViewAll,
          child: Text('View All',
              style: TextStyle(
                color: actionColor,
                fontWeight: FontWeight.w700,
              )),
        ),
      ],
    );
  }
}
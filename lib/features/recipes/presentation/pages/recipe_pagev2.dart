import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_demo/app/di.dart';
import 'package:app_demo/core/extention/mediaquery_size_extension.dart';
import 'package:app_demo/features/recipes/domain/entities/recipe.dart';
import 'package:app_demo/features/recipes/domain/usecases/search_recipes_usecase.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_event.dart';
import 'package:app_demo/features/recipes/presentation/bloc/recipe_state.dart';
import 'package:app_demo/features/recipes/presentation/pages/recipe_detail_pagev2.dart';
import 'package:app_demo/features/recipes/presentation/widgets/appbar_recipes_widget.dart';
import 'package:app_demo/features/recipes/presentation/widgets/card_product_widget.dart';
import 'package:app_demo/features/recipes/presentation/widgets/catagory_selector_widget.dart';

class RecipeHomePage extends StatefulWidget {
  const RecipeHomePage({super.key});

  @override
  State<RecipeHomePage> createState() => _RecipeHomePageState();
}

class _RecipeHomePageState extends State<RecipeHomePage> with WidgetsBindingObserver {
  final _controller = ScrollController(); // nếu bạn dùng CarouselView nội bộ, giữ controller phù hợp
  final _current = ValueNotifier(0);
  final _itemExtent = 260.0;

  late final RecipeBloc _recipeBloc;
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _recipeBloc = RecipeBloc(sl<SearchRecipesUsecase>());

    _controller.addListener(() {
      final i = (_controller.offset / _itemExtent).round();
      _current.value = i.clamp(0, 10);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = ModalRoute.of(context);
      final isCurrent = route?.isCurrent ?? true;
      if (isCurrent) _maybeLoadInitial();
    });
  }

  void _maybeLoadInitial() {
    if (!_dataLoaded) {
      _recipeBloc.add(SearchSubmitted("leek"));
      _dataLoaded = true;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if ((route?.isCurrent ?? false) && !_dataLoaded) {
      _maybeLoadInitial();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final route = ModalRoute.of(context);
      debugPrint("App vào lại (foreground)");
      if (route?.isCurrent ?? true) _maybeLoadInitial();
    }  else if (state == AppLifecycleState.paused) {
      debugPrint("App bị ẩn (background)");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _current.dispose();
    _recipeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _recipeBloc,
      child: Scaffold(
        appBar: const AppbarRecipesWidget(nameUser: "Alnena Sabyan"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<RecipeBloc, RecipeState>(
            builder: (context, state) {
              final items = state.items;
              final isLoading = state.loading;
              final error = state.error;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (error != null)
                    Center(
                      child: Text('⚠️ Error: $error',
                          style: const TextStyle(color: Colors.red)),
                    ),
                  Text(
                    "Featured",
                    style: GoogleFonts.sofiaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Nếu bạn dùng CarouselView của Flutter 3.22+: thay bằng widget đó
                  SizedBox(
                    height: 172.h,
                    child: isLoading && items.isEmpty
                        ? ListView.separated(
                            controller: _controller,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => SizedBox(
                              width: _itemExtent,
                              child: _FeaturedPlaceholder(),
                            ),
                            separatorBuilder: (context, index) => const SizedBox(width: 12),
                            itemCount: 3,
                          )
                        : ListView.separated(
                            controller: _controller,
                            scrollDirection: Axis.horizontal,
                            itemCount: items.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final recipe = items[index];
                              return SizedBox(
                                width: _itemExtent,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => RecipeDetailPagev2(id: recipe.id),
                                      ),
                                    );
                                  },
                                  child: _FeaturedCard(data: recipe),
                                ),
                              );
                            },
                          ),
                  ),

                  const SizedBox(height: 12),
                  const CategorySelector(),

                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => RecipeDetailPagev2(id: item.id),
                              ),
                            );
                          },
                          child: PopularRecipeCard(
                            widthCard: 250,
                            recipe: item,
                            onTapFavorite: () {
                              // xử lý favorite nếu cần
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.data});
  final Recipe data;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final cardWidth = constraints.maxWidth;
      final showContent = cardWidth >= context.pw(0.5);

      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SvgPicture.asset('assets/images/product_card.svg', fit: BoxFit.cover),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
            ),
            Positioned.fill(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 50),
                opacity: showContent ? 1 : 0,
                child: IgnorePointer(
                  ignoring: !showContent,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(
                          data.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const CircleAvatar(radius: 12),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                data.publisher,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.access_time, size: 14, color: Colors.white),
                                const SizedBox(width: 4),
                                Text(
                                  "${data.cookingTime} Min",
                                  maxLines: 1,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _FeaturedPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: Colors.grey.shade300,
          child: Column(
            children: [
              Expanded(child: Container(color: Colors.grey.shade400)),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [                    Container(height: 12, width: 120, color: Colors.grey),
                    const SizedBox(height: 8),
                    Container(height: 10, width: 80, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
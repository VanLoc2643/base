import 'package:app_demo/features/home/presentation/views/home_page.dart';
import 'package:app_demo/features/recipes/presentation/pages/recipe_pagev2.dart';
import 'package:app_demo/features/widgets/custom_circle_nav.dart';
import 'package:flutter/material.dart';
import 'package:app_demo/core/theme/app_color.dart';
import 'package:app_demo/features/recipes/presentation/pages/search/recipe_search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final _pages = const <Widget>[
    RecipeHomePage(),          // tách ra từ RecipePagev2
    RecipeSearchScreen(),                 // bạn đã có
    Center(child: Text('Notifications Page')),
    Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomCircleNavBar(
        currentIndex: _currentIndex,
        onChanged: (i) => setState(() => _currentIndex = i),
        // có thể truyền thêm màu nếu muốn
        bgColor: Colors.white,
        activeColor: AppColors.light1,
        inactiveColor: AppColors.primary0,
        circleColor: AppColors.dark2,
      ),
    );
  }
}

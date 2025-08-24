import 'package:app_demo/core/theme/app_color.dart';
import 'package:app_demo/features/onboarding.dart';
import 'package:flutter/material.dart';
import '../features/recipes/presentation/pages/recipe_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shope',
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: AppColors.primary1,
          fontFamily: 'SofiaPro'),
      debugShowCheckedModeBanner: false,
      home: const OnboardingPage(),
    );
  }
}

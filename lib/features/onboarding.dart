import 'package:app_demo/core/theme/app_color.dart';
import 'package:app_demo/core/theme/app_text_styles.dart';
import 'package:app_demo/features/home/presentation/views/home_page.dart';
import 'package:app_demo/features/recipes/presentation/pages/recipe_page.dart';
import 'package:app_demo/features/recipes/presentation/pages/recipe_pagev2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
                child: SvgPicture.asset(
              'assets/images/onboarding.svg', // <-- sửa path
              fit: BoxFit.cover,
              placeholderBuilder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            )),
            // Nút Later góc trên phải
            // Positioned(
            //   top: 16,
            //   right: 16,
            //   child: TextButton(
            //     onPressed: () {},
            //     child: const Text(
            //       "Later",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            Positioned(
                top: 8,
                right: 10,
                child: TextButton(
                    onPressed: () {
                      //todo : chuyen trang
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                    },
                    child: Text(
                      'Later',
                      style: AppTextStyle.variant(AppTextVariant.bold16,
                          color: AppColors.light1),
                    ))),
            // Nội dung chính
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // Hình minh họa: có thể thay bằng asset hoặc network

                const SizedBox(height: 380),

                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text("Help your path to health goals with happiness",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sofiaSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: AppColors.light1))),

                const SizedBox(height: 40),

                // Nút Login
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.dark2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text("Login",
                          style: GoogleFonts.sofiaSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.light1)),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Nút Create Account
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecipePage(),
                        ));
                  },
                  child: const Text(
                    "Create New Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                const Spacer(),

                // Indicator (thanh ngang dưới cùng)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  width: 120,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:app_demo/core/extention/mediaquery_size_extension.dart';
import 'package:app_demo/core/theme/app_color.dart';
import 'package:app_demo/core/widgets/bottom_navbar_widget.dart';
import 'package:app_demo/features/home/widgets/appbar_home_widget.dart';
import 'package:app_demo/features/home/widgets/header_card_widget.dart';
import 'package:app_demo/features/home/widgets/menu_row_widget.dart';
import 'package:app_demo/features/home/widgets/product_card_stack.dart';
import 'package:app_demo/features/home/widgets/recommend_widget.dart';
import 'package:app_demo/features/stack/card_stack_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_demo/features/home/widgets/product_card_product.dart'
    as product_card;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController =
      PageController(viewportFraction: 1, keepPage: false);
  int _selectedIndex = 0; // Thêm biến này nếu chưa có
  final List<String> _bannerImages = [
    'assets/images/banner2.png',
    'assets/images/banner2.png',
    'assets/images/banner2.png',
    'assets/images/banner2.png',
    'assets/images/banner2.png',
  ];
  int _currentBanner = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    if (index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CardStackScreen(),
          ));
    }
    {
      setState(() {
        _selectedIndex = index;
      });
    }

    print('Bottom Navigation Item $index tapped');
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      appBar: AppbarHomeWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80, // Đảm bảo chiều cao đủ lớn
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _bannerImages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentBanner = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.asset(
                      _bannerImages[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const FeatureMenuRow(),
              HeaderWithFloatingCard(),
              RecommendedSection(),
              GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2 / 3),
                  itemBuilder: (context, index) {
                    return product_card.ProductCard();
                  },
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics()),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 240,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5A1F),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Card products',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .4,
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              ProductCardStack(
                children: List.generate(4, (index) {
                  return const product_card.ProductCard();
                }),
                swipeThreshold: 40,
                onCardSwiped: (index, direction) {
                  // Xử lý khi thẻ được vuốt
                  print('Card $index swiped $direction');
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}

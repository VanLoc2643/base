import 'dart:async';
import 'package:flutter/material.dart';

mixin AutoSlideMixin<T extends StatefulWidget> on State<T> {
  late final PageController pageController;
  Timer? _timer;
  int currentIndex = 0;

  void initAutoSlide({
    Duration interval = const Duration(seconds: 3),
    Duration animationDuration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOut,
    required int itemCount,
  }) {
    pageController = PageController();
    _timer = Timer.periodic(interval, (_) {
      if (pageController.hasClients && mounted) {
        final nextIndex = (currentIndex + 1) % itemCount;
        pageController.animateToPage(
          nextIndex,
          duration: animationDuration,
          curve: curve,
        );
      }
    });
  }

  void onPageChanged(int index) {
    if (mounted) {
      setState(() => currentIndex = index);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    pageController.dispose();
    super.dispose();
  }
}

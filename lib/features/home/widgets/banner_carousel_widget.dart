import 'dart:async';
import 'package:app_demo/core/mixins/auto_slider_mixin.dart';
import 'package:flutter/material.dart';

class BannerCarousel extends StatefulWidget {
  final List<Widget> items;
  final Duration autoPlayInterval;

  const BannerCarousel({
    super.key,
    required this.items,
    this.autoPlayInterval = const Duration(milliseconds: 600),
  });

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> with AutoSlideMixin {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    initAutoSlide(
      itemCount: widget.items.length,
      interval: widget.autoPlayInterval,
      animationDuration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 180,
          child: GestureDetector(
            onTapDown: (_) => _timer?.cancel(),
            onTapUp: (_) => initAutoSlide(
              itemCount: widget.items.length,
              interval: widget.autoPlayInterval,
            ),
            onHorizontalDragStart: (_) => _timer?.cancel(),
            onHorizontalDragEnd: (_) => initAutoSlide(
              itemCount: widget.items.length,
              interval: widget.autoPlayInterval,
            ),
            child: PageView.builder(
              controller: pageController,
              onPageChanged: onPageChanged,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: widget.items[index],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.items.length, (index) {
            final isActive = index == currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isActive ? 16 : 6,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: isActive ? Colors.white : Colors.white54,
              ),
            );
          }),
        ),
      ],
    );
  }
}

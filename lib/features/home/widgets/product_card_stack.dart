import 'package:flutter/material.dart';
import 'dart:math';

class ProductCardStack extends StatefulWidget {
  const ProductCardStack({
    super.key,
    required this.children,
    this.onCardSwiped,
    this.maxAheadCards = 3,
    this.swipeThreshold = 200.0,
  });

  final List<Widget> children;
  final void Function(int index, SwipedDirection direction)? onCardSwiped;
  final int maxAheadCards;
  final double swipeThreshold;

  @override
  State<ProductCardStack> createState() => _ProductCardStackState();
}

enum SwipedDirection { left, right }

class _ProductCardStackState extends State<ProductCardStack>
    with TickerProviderStateMixin {
  // State
  late List<Widget> _cards;
  int _currentIndex = 0;

  // Top card animation state
  double _dx = 0.0;
  double _rotation = 0.0;
  double _opacity = 1.0;
  double _scale = 1.0;

  // Next card animation state
  double _nextCardScale = 0.9;

  // Animation controllers
  late AnimationController _swipeController;
  late AnimationController _nextCardController;

  // Animation constants
  static const _kSwipeOutDuration = Duration(milliseconds: 250);
  static const _kNextCardDuration = Duration(milliseconds: 250);
  static const double _kBottomStep = 3.8;
  static const double _kLeftStep = 0.0;
  static const double _kScaleStep = 0.03;
  static const double _kMinScale = 0.90;

  @override
  void initState() {
    super.initState();
    _cards = List.from(widget.children);

    _swipeController = AnimationController(
      vsync: this,
      duration: _kSwipeOutDuration,
    )..addStatusListener(_onSwipeAnimationStatusChange);

    _nextCardController = AnimationController(
      vsync: this,
      duration: _kNextCardDuration,
    )..addListener(() {
        setState(() {
          _nextCardScale = Tween<double>(begin: 0.97, end: 1.0)
              .animate(
                CurvedAnimation(
                    parent: _nextCardController, curve: Curves.easeOut),
              )
              .value;
        });
      });
  }

  @override
  void dispose() {
    _swipeController.dispose();
    _nextCardController.dispose();
    super.dispose();
  }

  void _onSwipeAnimationStatusChange(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        // Remove card and reset state for the new top card
        _cards.removeAt(0);
        _currentIndex++;
        _swipeController.reset();
        _dx = 0;
        _rotation = 0;
        _opacity = 1.0;
        _scale = 1.0;
        _nextCardController.forward(from: 0.0);
      });
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dx += details.delta.dx;
      _rotation = (_dx / 1000).clamp(-0.2, 0.2);
      _scale = (1.0 - (_dx.abs() / 2000)).clamp(0.95, 1.0);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dx;

    if (_dx.abs() > widget.swipeThreshold || velocity.abs() > 400) {
      final direction = _dx > 0 ? SwipedDirection.right : SwipedDirection.left;
      final targetX = _dx > 0 ? 500.0 : -500.0;

      // Notify parent widget
      widget.onCardSwiped?.call(_currentIndex, direction);

      // Animate card out
      final swipeAnimation = Tween<double>(begin: _dx, end: targetX).animate(
          CurvedAnimation(parent: _swipeController, curve: Curves.easeOut));
      final opacityAnimation =
          Tween<double>(begin: 0.2, end: 0.0).animate(_swipeController);

      _swipeController.addListener(() {
        setState(() {
          _dx = swipeAnimation.value;
          _opacity = opacityAnimation.value;
        });
      });
      _swipeController.forward();
    } else {
      // Animate back to center
      setState(() {
        _dx = 0;
        _rotation = 0;
        _scale = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cards.isEmpty) {
      return const Center(child: Text("Hết sản phẩm sales"));
    }

    return Stack(
      alignment: Alignment.center,
      children: _cards
          .asMap()
          .entries
          .map((entry) {
            final cardIndex = entry.key;
            final cardWidget = entry.value;

            if (cardIndex > widget.maxAheadCards) {
              return const SizedBox.shrink();
            }

            if (cardIndex == 0) {
              // Top card - Draggable
              return Transform.translate(
                offset: Offset(_dx, 0),
                child: GestureDetector(
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: _onPanEnd,
                  child: Opacity(
                    opacity: _opacity,
                    child: Transform.scale(
                      scale: _scale,
                      child: Transform.rotate(
                        angle: _rotation,
                        child: cardWidget,
                      ),
                    ),
                  ),
                ),
              );
            }

            // Background cards
            // Background cards
            final scale = cardIndex == 1
                ? _nextCardScale
                : max(_kMinScale, 1.0 - ((cardIndex - 1) * _kScaleStep));
            final bottomOffset = cardIndex * _kBottomStep;

            return Positioned(
              bottom: bottomOffset,
              child: Transform.scale(
                scale: cardIndex == 1 ? _nextCardScale : scale,
                child: cardWidget,
              ),
            );
          })
          .toList()
          .reversed
          .toList(),
    );
  }
}

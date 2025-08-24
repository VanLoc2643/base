import 'package:flutter/material.dart';

mixin FadeAnimationMixin<T extends StatefulWidget> on State<T>
    implements TickerProvider {
  late final AnimationController controller;
  late final Animation<double> fade;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    fade = Tween<double>(begin: 0, end: 1).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

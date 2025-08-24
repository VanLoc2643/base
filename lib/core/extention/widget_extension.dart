import 'package:flutter/material.dart';

extension WidgetX on Widget {
  Widget withPadding([EdgeInsets padding = const EdgeInsets.all(8)]) =>
      Padding(padding: padding, child: this);

  Widget withCard({double radius = 8}) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: this,
      );
}

import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';

class CustomCircleNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  final Color bgColor;
  final Color activeColor;
  final Color inactiveColor;
  final Color circleColor;

  const CustomCircleNavBar({
    super.key,
    required this.currentIndex,
    required this.onChanged,
    required this.bgColor,
    required this.activeColor,
    required this.inactiveColor,
    required this.circleColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircleNavBar(
      activeIndex: currentIndex,
      onTap: onChanged,
      height: 70,
      circleWidth: 55,
      color: bgColor,
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10, top: 10),
      activeIcons: [
        Icon(Icons.home,          color: activeColor),
        Icon(Icons.search,        color: activeColor),
        Icon(Icons.notifications, color: activeColor),
        Icon(Icons.person,        color: activeColor),
      ],
      inactiveIcons: [
        Icon(Icons.home,          color: inactiveColor),
        Icon(Icons.search,        color: inactiveColor),
        Icon(Icons.notifications, color: inactiveColor),
        Icon(Icons.person,        color: inactiveColor),
      ],
      circleColor: circleColor,
      elevation: 10,
      shadowColor: const Color.fromARGB(22, 0, 0, 0),
      cornerRadius: BorderRadius.circular(33),
    );
  }
}

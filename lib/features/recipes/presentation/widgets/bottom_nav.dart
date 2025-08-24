import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomAppBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabItem(
              icon: Icons.home,
              index: 0,
            ),
            _buildTabItem(
              icon: Icons.search,
              index: 1,
            ),
            const SizedBox(width: 40), // chừa chỗ FAB
            _buildTabItem(
              icon: Icons.notifications,
              index: 2,
            ),
            _buildTabItem(
              icon: Icons.person,
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({required IconData icon, required int index}) {
    final isSelected = index == currentIndex;
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? Colors.teal : Colors.grey,
      ),
      onPressed: () => onTabSelected(index),
    );
  }
}
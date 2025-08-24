import 'package:app_demo/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class FeatureMenuRow extends StatelessWidget {
  const FeatureMenuRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            FeatureMenuItem(
              label: 'New User',
              icon: Icon(Icons.person_add, size: 22, color: Colors.orange),
            ),
            FeatureMenuItem(
              label: 'MariBank',
              icon: Icon(Icons.account_balance, size: 22, color: Colors.orange),
            ),
            FeatureMenuItem(
              label: 'Daily Vouchers',
              icon:
                  Icon(Icons.local_activity, size: 22, color: Colors.redAccent),
              showBadge: true,
            ),
            FeatureMenuItem(
              label: 'Shopee Prizes',
              icon: Icon(Icons.card_giftcard, size: 22, color: Colors.indigo),
            ),
            FeatureMenuItem(
              label: 'See More',
              icon: Icon(Icons.apps, size: 22, color: Colors.orange),
            ),
            FeatureMenuItem(
              label: 'See More',
              icon: Icon(Icons.apps, size: 22, color: Colors.orange),
            ),
            FeatureMenuItem(
              label: 'See More',
              icon: Icon(Icons.apps, size: 22, color: Colors.orange),
            ),
            FeatureMenuItem(
              label: 'See More',
              icon: Icon(Icons.apps, size: 22, color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureMenuItem extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback? onTap;
  final bool showBadge;

  const FeatureMenuItem({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(14);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: r,
                onTap: onTap,
                child: Ink(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: r,
                    border: Border.all(
                        color: AppColors.dark1.withValues(alpha: .06)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(child: icon),
                ),
              ),
            ),
            if (showBadge)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 66,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

import 'dart:async';

import 'package:app_demo/core/mixins/auto_slider_mixin.dart';
import 'package:app_demo/core/theme/app_color.dart';
import 'package:app_demo/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 236, 220),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            // Ribbon tiêu đề
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 240,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5A1F),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'RECOMMENDED FOR YOU',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: .4,
                    ),
                  ),
                ),
                // hai "đuôi" nhỏ hai bên cho giống ribbon
                Positioned(
                  left: -10,
                  top: 0,
                  bottom: 0,
                  child: CustomPaint(
                    painter: _RibbonTailPainter(color: const Color(0xFFFF5A1F)),
                    size: const Size(14, 32),
                  ),
                ),
                Positioned(
                  right: -10,
                  top: 0,
                  bottom: 0,
                  child: CustomPaint(
                    painter: _RibbonTailPainter(
                        color: const Color(0xFFFF5A1F), flip: true),
                    size: const Size(14, 32),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== Left: 2 ticket vouchers =====
                Expanded(
                  flex: 11,
                  child: Column(
                    children: [
                      TicketVoucher(
                        color: const Color(0xFFFF5A1F),
                        title: '\$10 off',
                        badge: 'First Purchase Only',
                        line2: 'Min. Spend \$0',
                        line3: 'Valid for 30 days',
                        onUse: () {},
                        tncOnTap: () {},
                        punchColor: bg, // màu nền để "đục lỗ"
                      ),
                      const SizedBox(height: 8),
                      TicketVoucher(
                        color: const Color(0xFF1BB2AA),
                        title: 'Min Spend \$0',
                        badge: 'First Purchase Only',
                        line2: 'Valid for 30 days',
                        line3: '',
                        onUse: () {},
                        tncOnTap: () {},
                        punchColor: bg,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // ===== Right: product card + dots =====
                const Expanded(
                  flex: 14,
                  child: ProductCard(
                    images: [
                      'https://images.unsplash.com/photo-1556228720-195a672e8a03?q=80&w=800&auto=format&fit=crop',
                      'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?q=80&w=800&auto=format&fit=crop',
                      'https://images.unsplash.com/photo-1556228720-195a672e8a03?q=80&w=800&auto=format&fit=crop',
                    ],
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

/// VOUCHER kiểu ticket: bên trái là dải màu (đục 1 lỗ tròn ở giữa), bên phải là thẻ nội dung.
class TicketVoucher extends StatelessWidget {
  final Color color;
  final String title;
  final String badge;
  final String line2;
  final String line3;
  final VoidCallback onUse;
  final VoidCallback tncOnTap;
  final Color punchColor;

  const TicketVoucher({
    super.key,
    required this.color,
    required this.title,
    required this.badge,
    required this.line2,
    required this.line3,
    required this.onUse,
    required this.tncOnTap,
    required this.punchColor,
  });

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(8);

    return Material(
      elevation: 3,
      shadowColor: Colors.black12,
      borderRadius: r,
      child: Row(
        children: [
          // Strip màu bên trái
          SizedBox(
            width: 76,
            height: 120,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius:
                        const BorderRadius.horizontal(left: Radius.circular(8)),
                  ),
                ),
                // đường viền đứt đoạn sát mép phải cho giống perforation
                Positioned.fill(
                  right: 0,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 1,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // chấm tròn "đục lỗ" ở giữa mép
                Positioned(
                  right: -8,
                  top: 52,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: punchColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withValues(alpha: .6), width: 1),
                    ),
                  ),
                ),

                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.local_activity,
                                color: Colors.white, size: 22),
                            const SizedBox(height: 6),
                            Text(
                              color.value == const Color(0xFFFF5A1F).value
                                  ? 'NEW USER\nVOUCHER'
                                  : 'FREE\nSHIPPING',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  height: 1.1,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Nội dung voucher
          Expanded(
            child: Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      // T&C
                      // InkWell(
                      //   onTap: tncOnTap,
                      //   child: const Text(
                      //     'T&C',
                      //     style: TextStyle(color: Colors.black45, fontSize: 12),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: double.infinity,
                    height: 25,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.light1,
                    ),
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: handle click
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: AppColors.primary1,
                          width: 0.5, // 👈 chỉnh độ dày viền ở đây
                        ), // viền đỏ
                        foregroundColor: Colors.orange, // chữ đỏ
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 2),

                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                      child: Text(
                        "sale",
                        style: AppTextStyle.variant(
                          AppTextVariant.regular8,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final List<String> images;
  const ProductCard({super.key, required this.images});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> with AutoSlideMixin {
  @override
  void initState() {
    super.initState();
    initAutoSlide(
      itemCount: widget.images.length,
      interval: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(16);

    return Material(
      elevation: 3,
      shadowColor: Colors.black12,
      borderRadius: r,
      child: ClipRRect(
        borderRadius: r,
        child: Container(
          height: 248,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController, // Sử dụng từ mixin
                  itemCount: widget.images.length,
                  onPageChanged: onPageChanged, // Sử dụng từ mixin
                  itemBuilder: (_, i) => Container(
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5EF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      widget.images[i],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Center(child: Icon(Icons.image_not_supported)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.images.length, (i) {
                  final active = i == currentIndex; // Sử dụng từ mixin
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                    width: active ? 8 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: active ? AppColors.primary1 : AppColors.light4,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Vẽ "đuôi" cho ribbon tiêu đề
class _RibbonTailPainter extends CustomPainter {
  final Color color;
  final bool flip;
  _RibbonTailPainter({required this.color, this.flip = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    if (!flip) {
      path.moveTo(size.width, 0);
      path.lineTo(0, size.height / 2);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(0, size.height);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

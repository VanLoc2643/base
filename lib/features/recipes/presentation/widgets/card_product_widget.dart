// ...existing code...
import 'dart:math' as math;

import 'package:app_demo/features/recipes/domain/entities/recipe.dart';
import 'package:flutter/material.dart';

// ...existing code...
class PopularRecipeCard extends StatelessWidget {
  const PopularRecipeCard({
    super.key,
    required this.recipe,
    this.kcal = 9,
    this.onTapFavorite,
    this.isFavorite = false,
    required this.widthCard,
    this.showIcon = true,
  });

  final Recipe recipe;
  final bool showIcon;
  final int? kcal;
  final double widthCard;
  final VoidCallback? onTapFavorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    // đảm bảo width tối thiểu để không bị vỡ layout khi width truyền vào quá nhỏ
    final minWidth = 140.0;
    final effectiveWidth = math.max(minWidth, widthCard);

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () {
          // Xử lý khi người dùng nhấn vào thẻ
        },
        borderRadius: BorderRadius.circular(16),
        child: LayoutBuilder(builder: (context, constraints) {
          // chiều cao ảnh tỉ lệ theo width hiện tại (vừa phải, không cố định cứng)
          final containerWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : effectiveWidth;
          final imageHeight = math.max(80.0, containerWidth * 0.40).clamp(60.0, 200.0);

          return Container(
            width: containerWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image + Favorite button
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        recipe.imageUrl,
                        height: imageHeight,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        // hiển thị placeholder/error thay vì crash
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: imageHeight,
                            color: Colors.grey.shade300,
                            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: imageHeight,
                            color: Colors.grey.shade300,
                            child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: onTapFavorite,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: showIcon
                              ? Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.black54,
                                  size: 18,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ),
                  ],
                ),
                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Flexible(
                    child: Text(
                      recipe.title,
                      softWrap: true,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // Info Row (kcal, time)
             
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8 ),
                    child: Row(
                      children: [
                        const Icon(Icons.local_fire_department, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            '$kcal Kcal',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // dùng Expanded nhỏ để đẩy thời gian sang phải mà không gây overflow
        
                        const Spacer(),
                        const Icon(Icons.access_time, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            '${recipe.cookingTime} Min',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),

              ],
            ),
          );
        }),
      ),
    );
  }
}
// ...existing code...
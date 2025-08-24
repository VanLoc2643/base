import 'package:app_demo/core/theme/app_color.dart';
import 'package:app_demo/core/theme/app_dimens.dart';
import 'package:app_demo/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppbarHomeWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarHomeWidget({super.key});
  @override
  Size get preferredSize => Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: AppColors.primary1,
      elevation: 2,
      flexibleSpace: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      height: AppDimens.h32,
                      decoration: BoxDecoration(
                        color: AppColors.light1,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: TextField(
                        style: AppTextStyle.variant(AppTextVariant.regular16,
                            color: AppColors.primary1),
                        cursorColor: AppColors.primary1,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Tìm kiếm sản phẩm',
                          hintStyle: AppTextStyle.variant(
                              AppTextVariant.regular16,
                              color: AppColors.primary1),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search,
                              color: AppColors.primary1, size: 20.sp),
                        ),
                        onSubmitted: (value) {
                          // Xử lý tìm kiếm khi nhấn Enter
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined,
                        color: AppColors.light1),
                    onPressed: () {
                      // Handle notification button press
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.message_outlined,
                        color: Colors.white, size: 20.sp),
                    onPressed: () {
                      // Handle menu button press
                    },
                  ),
                ],
              ))),
    );
  }
}

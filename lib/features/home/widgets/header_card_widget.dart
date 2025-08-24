import 'package:app_demo/core/theme/app_color.dart';
import 'package:app_demo/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class HeaderWithFloatingCard extends StatelessWidget {
  const HeaderWithFloatingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Stack(
        children: [
          // Header màu cam
          // Card nổi
          Positioned(
            left: 12,
            right: 12,
            top: 10,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              shadowColor: Colors.black26,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.crop_free,
                          color: AppColors.dark1,
                        ), // Replace 'Icons.home' with your desired icon
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: VerticalDivider(
                          color: Colors.grey.shade300, thickness: 1),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.monetization_on,
                                  color: AppColors.primary1),
                              SizedBox(
                                width: 4,
                              ),
                              Text('\$0.00',
                                  style: AppTextStyle.variant(
                                      AppTextVariant.regular16,
                                      color: AppColors.dark1)),
                            ],
                          ),
                          Text(
                            '\Earn cashback\nwith ShopeePay',
                            style: AppTextStyle.variant(
                              AppTextVariant.regular12,
                              color: AppColors.dark1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: VerticalDivider(
                          color: Colors.grey.shade300, thickness: 1),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.monetization_on,
                                  color: Color.fromARGB(255, 255, 151, 5)),
                              SizedBox(
                                width: 4,
                              ),
                              Text('\$0.00',
                                  style: AppTextStyle.variant(
                                      AppTextVariant.regular16,
                                      color: AppColors.dark1)),
                            ],
                          ),
                          Text(
                            '\Coin',
                            style: AppTextStyle.variant(
                              AppTextVariant.regular12,
                              color: AppColors.dark1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

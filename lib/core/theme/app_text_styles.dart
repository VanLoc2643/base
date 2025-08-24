
import 'package:app_demo/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppTextStyle extends TextStyle {
  AppTextStyle.variant(
    AppTextVariant variant, {
    super.color,
    super.fontStyle = FontStyle.normal,
    TextDecoration? textDecoration = TextDecoration.none,
    Color? textDecorationColor,
  }) : super(
          fontFamily: UiConstants.defaultFontFamily,
          fontSize: variant.textSize.pixels,
          fontWeight: variant.fontWeight,
          height: 1.5,
          decoration: textDecoration,
          decorationColor: textDecorationColor,
        );
}

enum AppTextSize {
  size8(8),
  size9(9),
  size10(10),
  size12(12),
  size14(14),
  size16(16),
  size18(18),
  size20(20),
  size24(24),
  size32(32),
  size80(80);

  final double baseSize;

  const AppTextSize(this.baseSize);

  double get pixels => baseSize.sp;
}

enum AppTextVariant {
  regular8(AppTextSize.size8, FontWeight.w400),
  regular18(AppTextSize.size18, FontWeight.w400),
  regular9(AppTextSize.size9, FontWeight.w400),
  regular10(AppTextSize.size10, FontWeight.w400),
  regular12(AppTextSize.size12, FontWeight.w400),
  regular14(AppTextSize.size14, FontWeight.w400),
  regular16(AppTextSize.size16, FontWeight.w400),
  regular20(AppTextSize.size20, FontWeight.w400),
  medium9(AppTextSize.size9, FontWeight.w500),
  medium10(AppTextSize.size10, FontWeight.w500),
  medium12(AppTextSize.size12, FontWeight.w500),
  medium14(AppTextSize.size14, FontWeight.w500),
  medium16(AppTextSize.size16, FontWeight.w500),
  medium18(AppTextSize.size18, FontWeight.w500),
  semiBold14(AppTextSize.size14, FontWeight.w600),
  semiBold12(AppTextSize.size12, FontWeight.w600),
  semiBold10(AppTextSize.size10, FontWeight.w600),
  semiBold16(AppTextSize.size16, FontWeight.w600),
  semiBold18(AppTextSize.size18, FontWeight.w600),
  semiBold20(AppTextSize.size20, FontWeight.w600),
  semiBold24(AppTextSize.size24, FontWeight.w600),
  bold16(AppTextSize.size16, FontWeight.w700),
  bold20(AppTextSize.size20, FontWeight.w700),
  bold24(AppTextSize.size24, FontWeight.w700),
  bold32(AppTextSize.size24, FontWeight.w700),
  bold80(AppTextSize.size80, FontWeight.w700);
  final AppTextSize textSize;
  final FontWeight fontWeight;

  const AppTextVariant(this.textSize, this.fontWeight);
}

import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); //! ngăn việc tạo contructor vì bên trong class này chỉ là static AppColors đâu có thuộc tính động, chỉ toàn static const.

  static const Color transparent = Color(0x00FFFFFF);

  // Primary
  static const Color primary6 = Color(0xFFECF3FE);
  static const Color primary5 = Color(0xFFD9E7FD);
  static const Color primary4 = Color(0xFFB3CEFB);
  static const Color primary3 = Color(0xFF8EB6F8);
  static const Color primary2 = Color(0xffecdc);
  static const Color primary1 = Color.fromARGB(255, 237, 78, 46);
  static const Color primary0 = Color(0xff70b9be);

  // Accent
  static const Color accent6 = Color(0xFFFFF8E6);
  static const Color accent5 = Color(0xFFFEE2CD);
  static const Color accent4 = Color(0xFFFDE49B);
  static const Color accent3 = Color(0xFFFDD769);
  static const Color accent2 = Color(0xFFFCB937);
  static const Color accent1 = Color(0xFFF8BC05);
  static const Color accent0 = Color(0xFFF8B905);

  // Error
  static const Color error6 = Color(0xFFFFF5F5);
  static const Color error5 = Color(0xFFFDD5D7);
  static const Color error4 = Color(0xFFFDA2A9);
  static const Color error3 = Color(0xFFFD6F7A);
  static const Color error2 = Color(0xFFF2655F);
  static const Color error1 = Color(0xFFEF3F37);
  static const Color error0 = Color(0xFFEB170D);

  // Success
  static const Color success6 = Color(0xFFE5F6EC);
  static const Color success5 = Color(0xFFCCEE09);
  static const Color success4 = Color(0xFF99DCB4);
  static const Color success3 = Color(0xFF66CB8E);
  static const Color success2 = Color(0xFF338969);
  static const Color success1 = Color(0xFF00A843);
  static const Color success0 = Color(0xFF027C33);

  // Dark
  static const Color background1 = Color(0xf5f5f5);
  static const Color dark5 = Color(0xFF7A7E80);
  static const Color dark4 = Color(0xFF464A4D);
  static const Color dark3 = Color(0xFF2D2E30);
  static const Color dark2 = Color(0xFF042628);
  static const Color dark1 = Color(0xFF0D0E0F);

  // Light
  static const Color light6 = Color(0xFFD5D5D5);
  static const Color light5 = Color(0xFFE3E5E5);
  static const Color light4 = Color(0xFFF2F4F5);
  static const Color light3 = Color(0xFFF7F9FA);
  static const Color light2 = Color(0xFFFBFBFB);
  static const Color light1 = Color(0xFFFFFFFF);

  static const Color overlayLoading = Color(0x33000000);
  static const Color dialogBarrierColor = Colors.black45;

  static const Color statusBarLogin = Color(0xFF9F9F9F);

  static const Color loginFacebook = Color(0xFF1877F2);
  static const Color loginGoogle = Color(0x730D0E0F);
  static const Color loginApple = Color(0xFF0D0E0F);
}

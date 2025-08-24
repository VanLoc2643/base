import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppbarRecipesWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String nameUser;
  const AppbarRecipesWidget({super.key, required this.nameUser});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.wb_sunny_outlined,
                      size: 18, color: Colors.blueGrey),
                  SizedBox(width: 6),
                  Text(
                    "Good Morning",
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                nameUser,
                style: GoogleFonts.sofiaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ]),

            /// Bên phải: icon cart
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_outlined, size: 26),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

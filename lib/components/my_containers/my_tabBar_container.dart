import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTabBarContainer extends StatelessWidget {
  final String tabName;
  final IconData icon;
  final Color color;
  final Color textColor;
  final Color borderColor;
  const MyTabBarContainer(
      {super.key,
      required this.icon,
      required this.tabName,
      required this.color,
      required this.textColor,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5.5),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 1.5, color: borderColor)),
        child: Row(
          children: [
            /* Icon(
              icon,
              color: textColor,
              size: 22,
            ),*/
            const SizedBox(width: 5),
            Text(tabName,
                style: GoogleFonts.workSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
          ],
        ));
  }
}

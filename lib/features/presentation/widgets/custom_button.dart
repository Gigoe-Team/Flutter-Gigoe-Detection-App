import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.btnText,
    this.foregroundColor = const Color(0xff000000),
    this.backgroundColor = const Color(0xff4E73AF),
    this.onPressed,
    this.minimumSize = const Size(230, 48),
    this.textColor = Colors.white,
  });

  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Size? minimumSize;
  final String? btnText;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        minimumSize: minimumSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            50,
          ),
        ),
      ),
      child: Text(
        btnText.toString(),
        style: GoogleFonts.poppins(
            color: textColor, fontSize: 12, fontWeight: FontWeight.w400),
      ),
    );
  }
}

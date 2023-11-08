import 'package:flutter/material.dart';
import 'package:gigoe_detection_app/core/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.btnText,
    this.foregroundColor = AppColors.darkBlue,
    this.backgroundColor = AppColors.primaryBlue,
    this.onPressed,
    this.minimumSize = const Size(230, 45),
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

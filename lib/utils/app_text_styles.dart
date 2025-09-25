import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class AppTextStyles {
  // Headings
  static TextStyle get h1 => GoogleFonts.poppins(
        fontSize: 64,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
        height: 1.1,
      );

  static TextStyle get h2 => GoogleFonts.poppins(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
        height: 1.2,
      );

  static TextStyle get h3 => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.3,
      );

  static TextStyle get h4 => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.3,
      );

  // Body text
  static TextStyle get bodyLarge => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppColors.grey,
        height: 1.6,
      );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.grey,
        height: 1.6,
      );

  static TextStyle get bodySmall => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.grey,
        height: 1.5,
      );

  // Special styles
  static TextStyle get subtitle => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
        height: 1.4,
      );

  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.darkGrey,
        height: 1.4,
      );

  // Button styles
  static TextStyle get buttonLarge => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
        letterSpacing: 1.2,
      );

  static TextStyle get buttonMedium => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
        letterSpacing: 1.0,
      );

  // Navigation
  static TextStyle get navLink => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.grey,
        letterSpacing: 0.5,
      );

  // Responsive variants
  static TextStyle responsiveH1(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return h1.copyWith(fontSize: 40);
    } else if (screenWidth < 900) {
      return h1.copyWith(fontSize: 52);
    }
    return h1;
  }

  static TextStyle responsiveH2(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return h2.copyWith(fontSize: 32);
    } else if (screenWidth < 900) {
      return h2.copyWith(fontSize: 40);
    }
    return h2;
  }

  static TextStyle responsiveBody(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return bodyMedium.copyWith(fontSize: 14);
    }
    return bodyLarge;
  }
}
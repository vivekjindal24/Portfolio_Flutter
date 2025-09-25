import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color primary = Color(0xFF64FFDA);
  static const Color secondary = Color(0xFF8892B0);
  static const Color accent = Color(0xFFCCD6F6);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF8892B0);
  static const Color darkGrey = Color(0xFF495670);
  static const Color lightGrey = Color(0xFFA8B2D1);
  static const Color navy = Color(0xFF0A192F);
  static const Color darkNavy = Color(0xFF020C1B);
  
  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF64FFDA), Color(0xFF41B883)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF0A192F), Color(0xFF020C1B)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  final String number;
  final String title;
  final bool centerAlign;

  const SectionTitle({
    super.key,
    required this.number,
    required this.title,
    this.centerAlign = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Section number
        Text(
          number,
          style: AppTextStyles.subtitle.copyWith(
            fontFamily: 'monospace',
            fontSize: 18,
          ),
        ),
        
        const SizedBox(width: 10),
        
        // Section title
        Text(
          title,
          style: AppTextStyles.h3,
        ),
        
        const SizedBox(width: 30),
        
        // Decorative line
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );

    if (centerAlign) {
      return Center(child: content);
    }
    
    return content;
  }
}
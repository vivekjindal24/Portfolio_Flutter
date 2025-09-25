import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

enum ButtonVariant { filled, outlined, text }

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.filled,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.isLoading ? null : widget.onPressed,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.width,
            height: widget.height ?? 50,
            decoration: _getDecoration(),
            child: Center(
              child: widget.isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getTextColor(),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            color: _getTextColor(),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          widget.text,
                          style: AppTextStyles.buttonMedium.copyWith(
                            color: _getTextColor(),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getDecoration() {
    switch (widget.variant) {
      case ButtonVariant.filled:
        return BoxDecoration(
          gradient: _isHovered ? AppColors.primaryGradient : null,
          color: _isHovered ? null : AppColors.primary,
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        );
      case ButtonVariant.outlined:
        return BoxDecoration(
          border: Border.all(
            color: _isHovered ? AppColors.primary : AppColors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
          color: _isHovered
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
        );
      case ButtonVariant.text:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _isHovered
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
        );
    }
  }

  Color _getTextColor() {
    switch (widget.variant) {
      case ButtonVariant.filled:
        return AppColors.background;
      case ButtonVariant.outlined:
        return _isHovered ? AppColors.primary : AppColors.grey;
      case ButtonVariant.text:
        return _isHovered ? AppColors.primary : AppColors.grey;
    }
  }
}
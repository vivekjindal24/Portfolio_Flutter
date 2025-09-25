import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';

class CustomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final List<String> sections;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.sections,
    required this.onTap,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
    if (_isMenuOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 50,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.95),
        backdropFilter: const ColorFilter.mode(
          Colors.black26,
          BlendMode.darken,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo/Brand
          Text(
            'VJ',
            style: AppTextStyles.h4.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          if (isMobile) ...[
            // Mobile menu button
            IconButton(
              onPressed: _toggleMenu,
              icon: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: _animationController,
                color: AppColors.primary,
                size: 28,
              ),
            ),
          ] else ...[
            // Desktop navigation
            Row(
              children: [
                ...widget.sections.asMap().entries.map((entry) {
                  int index = entry.key;
                  String section = entry.value;
                  bool isActive = index == widget.currentIndex;
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: _NavItem(
                      title: section,
                      isActive: isActive,
                      onTap: () => widget.onTap(index),
                    ),
                  );
                }).toList(),
                const SizedBox(width: 20),
                CustomButton(
                  text: 'Resume',
                  onPressed: () {
                    // TODO: Open resume
                  },
                  variant: ButtonVariant.outlined,
                ),
              ],
            ),
          ],
        ],
      ),
      // Mobile menu overlay
      child: isMobile && _isMenuOpen
          ? _MobileMenu(
              sections: widget.sections,
              currentIndex: widget.currentIndex,
              onTap: (index) {
                widget.onTap(index);
                _toggleMenu();
              },
            )
          : null,
    );
  }
}

class _NavItem extends StatefulWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.isActive || _isHovered
                    ? AppColors.primary
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            widget.title,
            style: AppTextStyles.navLink.copyWith(
              color: widget.isActive || _isHovered
                  ? AppColors.primary
                  : AppColors.grey,
              fontWeight: widget.isActive
                  ? FontWeight.w600
                  : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final List<String> sections;
  final int currentIndex;
  final Function(int) onTap;

  const _MobileMenu({
    required this.sections,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80,
      right: 20,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...sections.asMap().entries.map((entry) {
              int index = entry.key;
              String section = entry.value;
              bool isActive = index == currentIndex;
              
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onTap(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.transparent,
                      border: Border(
                        left: BorderSide(
                          color: isActive
                              ? AppColors.primary
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      section,
                      style: AppTextStyles.navLink.copyWith(
                        color: isActive ? AppColors.primary : AppColors.grey,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            Container(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                text: 'Resume',
                onPressed: () {
                  // TODO: Open resume
                },
                variant: ButtonVariant.outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
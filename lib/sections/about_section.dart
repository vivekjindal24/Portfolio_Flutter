import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/section_title.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  final List<String> _technologies = [
    'Flutter',
    'Dart',
    'React',
    'JavaScript',
    'TypeScript',
    'Node.js',
    'Python',
    'Firebase',
    'MongoDB',
    'AWS',
    'Git',
    'Figma',
  ];

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    bool isTablet = ResponsiveBreakpoints.of(context).isTablet;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            number: '01',
            title: 'About Me',
          ),
          
          const SizedBox(height: 60),
          
          // Main content
          isMobile || isTablet
              ? Column(
                  children: [
                    _buildTextContent(),
                    const SizedBox(height: 40),
                    _buildProfileImage(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildTextContent(),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      flex: 2,
                      child: _buildProfileImage(),
                    ),
                  ],
                ),
          
          const SizedBox(height: 60),
          
          // Technologies section
          _buildTechnologies(),
        ],
      ),
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello! I\'m Vivek, a passionate software developer based in India. I enjoy creating things that live on the internet, whether that be websites, applications, or anything in between.',
          style: AppTextStyles.bodyLarge,
        ).animate()
          .fadeIn(delay: 200.ms, duration: 600.ms)
          .slideY(begin: 0.1, end: 0),
        
        const SizedBox(height: 20),
        
        Text(
          'My interest in software development started back in 2018 when I decided to learn programming. Fast-forward to today, and I\'ve had the privilege of working on various projects ranging from mobile applications to web platforms.',
          style: AppTextStyles.bodyLarge,
        ).animate()
          .fadeIn(delay: 400.ms, duration: 600.ms)
          .slideY(begin: 0.1, end: 0),
        
        const SizedBox(height: 20),
        
        Text(
          'My main focus these days is building accessible, inclusive products and digital experiences for a variety of clients. I most enjoy working on projects where I can combine my technical skills with creative problem-solving.',
          style: AppTextStyles.bodyLarge,
        ).animate()
          .fadeIn(delay: 600.ms, duration: 600.ms)
          .slideY(begin: 0.1, end: 0),
        
        const SizedBox(height: 30),
        
        // Key highlights
        _buildHighlights(),
      ],
    );
  }

  Widget _buildHighlights() {
    final highlights = [
      'Full-stack development experience',
      'Mobile app development specialist',
      'UI/UX design enthusiast',
      'Open source contributor',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick highlights:',
          style: AppTextStyles.subtitle.copyWith(fontSize: 18),
        ),
        
        const SizedBox(height: 15),
        
        ...highlights.asMap().entries.map((entry) {
          int index = entry.key;
          String highlight = entry.value;
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 8, right: 12),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    highlight,
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
              ],
            ).animate()
              .fadeIn(delay: Duration(milliseconds: 800 + (index * 100)))
              .slideX(begin: -0.1, end: 0),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 300,
        height: 350,
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                width: 280,
                height: 330,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            
            // Main image container
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 280,
                height: 330,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary.withOpacity(0.1),
                          AppColors.surface,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 120,
                          color: AppColors.primary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Profile Photo',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add your photo here',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // Hover overlay
            Positioned(
              top: 0,
              left: 0,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  width: 280,
                  height: 330,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ).animate()
        .fadeIn(delay: 400.ms, duration: 800.ms)
        .slideX(begin: 0.2, end: 0),
    );
  }

  Widget _buildTechnologies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Technologies I work with:',
          style: AppTextStyles.h4.copyWith(fontSize: 20),
        ).animate()
          .fadeIn(delay: 600.ms, duration: 600.ms),
        
        const SizedBox(height: 30),
        
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: _technologies.asMap().entries.map((entry) {
            int index = entry.key;
            String tech = entry.value;
            
            return _TechChip(
              text: tech,
              index: index,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _TechChip extends StatefulWidget {
  final String text;
  final int index;

  const _TechChip({
    required this.text,
    required this.index,
  });

  @override
  State<_TechChip> createState() => _TechChipState();
}

class _TechChipState extends State<_TechChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary
                : AppColors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          widget.text,
          style: AppTextStyles.bodySmall.copyWith(
            color: _isHovered ? AppColors.primary : AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ).animate()
        .fadeIn(delay: Duration(milliseconds: 800 + (widget.index * 50)))
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0)),
    );
  }
}
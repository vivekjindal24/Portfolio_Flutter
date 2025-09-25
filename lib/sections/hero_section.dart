import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/social_links.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _contentController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    // Start content animation after a brief delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _contentController.forward();
      }
    });
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    bool isTablet = ResponsiveBreakpoints.of(context).isTablet;
    
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Animated background
          _buildAnimatedBackground(),
          
          // Main content
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting
                Text(
                  'Hi, my name is',
                  style: AppTextStyles.subtitle.copyWith(
                    fontSize: isMobile ? 16 : 20,
                  ),
                ).animate(controller: _contentController)
                  .fadeIn(delay: 200.ms, duration: 600.ms)
                  .slideX(begin: -0.2, end: 0),
                
                const SizedBox(height: 20),
                
                // Name with gradient effect
                ShaderMask(
                  shaderCallback: (bounds) => AppColors.primaryGradient
                      .createShader(bounds),
                  child: Text(
                    'Vivek Jindal',
                    style: AppTextStyles.responsiveH1(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ).animate(controller: _contentController)
                  .fadeIn(delay: 400.ms, duration: 800.ms)
                  .slideX(begin: -0.2, end: 0),
                
                const SizedBox(height: 10),
                
                // Animated role text
                SizedBox(
                  height: isMobile ? 60 : 80,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'I build things for the web.',
                        textStyle: AppTextStyles.responsiveH2(context).copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        'I create mobile experiences.',
                        textStyle: AppTextStyles.responsiveH2(context).copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        'I design user interfaces.',
                        textStyle: AppTextStyles.responsiveH2(context).copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    repeatForever: true,
                    pause: const Duration(milliseconds: 2000),
                  ),
                ).animate(controller: _contentController)
                  .fadeIn(delay: 800.ms, duration: 600.ms),
                
                const SizedBox(height: 30),
                
                // Description
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    'I\'m a passionate software developer specializing in creating exceptional digital experiences. Currently, I\'m focused on building accessible, human-centered products.',
                    style: AppTextStyles.responsiveBody(context),
                  ),
                ).animate(controller: _contentController)
                  .fadeIn(delay: 1000.ms, duration: 600.ms)
                  .slideY(begin: 0.1, end: 0),
                
                const SizedBox(height: 50),
                
                // Call-to-action buttons
                Row(
                  children: [
                    CustomButton(
                      text: 'Get In Touch',
                      onPressed: () {
                        // TODO: Scroll to contact section
                      },
                      variant: ButtonVariant.filled,
                      width: isMobile ? null : 150,
                    ),
                    const SizedBox(width: 20),
                    CustomButton(
                      text: 'View Work',
                      onPressed: () {
                        // TODO: Scroll to projects section
                      },
                      variant: ButtonVariant.outlined,
                      width: isMobile ? null : 130,
                    ),
                  ],
                ).animate(controller: _contentController)
                  .fadeIn(delay: 1200.ms, duration: 600.ms)
                  .slideY(begin: 0.1, end: 0),
                
                const SizedBox(height: 60),
                
                // Social links
                const SocialLinks(),
                
                // Scroll indicator
                if (!isMobile) ...[
                  const SizedBox(height: 80),
                  _buildScrollIndicator(),
                ],
              ],
            ),
          ),
          
          // Floating elements for desktop
          if (!isMobile && !isTablet) ...[
            _buildFloatingElements(),
          ],
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(
                  0.3 + 0.2 * (_backgroundController.value * 2 - 1),
                  -0.2 + 0.1 * (_backgroundController.value * 2 - 1),
                ),
                radius: 1.0 + 0.2 * _backgroundController.value,
                colors: [
                  AppColors.primary.withOpacity(0.05),
                  AppColors.background,
                  AppColors.darkNavy,
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScrollIndicator() {
    return Center(
      child: Column(
        children: [
          Text(
            'Scroll down',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 10),
          Container(
            width: 2,
            height: 40,
            color: AppColors.primary.withOpacity(0.5),
            child: Container(
              alignment: Alignment.topCenter,
              child: Container(
                width: 2,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ).animate(onPlay: (controller) => controller.repeat())
                .slideY(begin: 0, end: 3, duration: 2.seconds)
                .then()
                .slideY(begin: -3, end: 0, duration: 2.seconds),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingElements() {
    return Stack(
      children: [
        // Floating code snippet
        Positioned(
          top: 150,
          right: 100,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'const developer = {',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontFamily: 'monospace',
                    color: AppColors.grey,
                  ),
                ),
                Text(
                  '  name: "Vivek Jindal",',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontFamily: 'monospace',
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  '  skills: ["Flutter", "React"],',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontFamily: 'monospace',
                    color: AppColors.accent,
                  ),
                ),
                Text(
                  '  passion: "Creating"',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontFamily: 'monospace',
                    color: AppColors.lightGrey,
                  ),
                ),
                Text(
                  '};',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontFamily: 'monospace',
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
            .slideY(begin: 0, end: -0.02, duration: 3.seconds),
        ),
        
        // Floating geometric shapes
        Positioned(
          top: 400,
          right: 50,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: AppColors.primary.withOpacity(0.3),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ).animate(onPlay: (controller) => controller.repeat())
            .rotate(duration: 10.seconds),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/section_title.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  final List<SkillCategory> _skillCategories = [
    SkillCategory(
      title: 'Frontend Development',
      icon: FontAwesomeIcons.laptop,
      skills: [
        Skill('Flutter', 95),
        Skill('React', 88),
        Skill('JavaScript', 90),
        Skill('TypeScript', 85),
        Skill('HTML/CSS', 92),
        Skill('Responsive Design', 88),
      ],
    ),
    SkillCategory(
      title: 'Backend Development',
      icon: FontAwesomeIcons.server,
      skills: [
        Skill('Node.js', 85),
        Skill('Python', 80),
        Skill('Firebase', 88),
        Skill('MongoDB', 82),
        Skill('PostgreSQL', 78),
        Skill('RESTful APIs', 90),
      ],
    ),
    SkillCategory(
      title: 'Mobile Development',
      icon: FontAwesomeIcons.mobileAlt,
      skills: [
        Skill('Flutter', 95),
        Skill('Dart', 92),
        Skill('iOS Development', 75),
        Skill('Android Development', 80),
        Skill('React Native', 70),
        Skill('App Store Deployment', 85),
      ],
    ),
    SkillCategory(
      title: 'Tools & Technologies',
      icon: FontAwesomeIcons.tools,
      skills: [
        Skill('Git/GitHub', 90),
        Skill('Docker', 75),
        Skill('AWS', 80),
        Skill('Figma', 85),
        Skill('VS Code', 95),
        Skill('Firebase', 88),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    bool isTablet = ResponsiveBreakpoints.of(context).isTablet;
    
    return Container(
      width: double.infinity,
      color: AppColors.surface.withOpacity(0.5),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          const SectionTitle(
            number: '02',
            title: 'Skills & Expertise',
            centerAlign: true,
          ),
          
          const SizedBox(height: 60),
          
          // Skills grid
          _buildSkillsGrid(context, isMobile, isTablet),
          
          const SizedBox(height: 80),
          
          // Additional info
          _buildAdditionalInfo(),
        ],
      ),
    );
  }

  Widget _buildSkillsGrid(BuildContext context, bool isMobile, bool isTablet) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 2),
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: isMobile ? 1.2 : 1.1,
      ),
      itemCount: _skillCategories.length,
      itemBuilder: (context, index) {
        return _SkillCategoryCard(
          category: _skillCategories[index],
          index: index,
        );
      },
    );
  }

  Widget _buildAdditionalInfo() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Always Learning',
            style: AppTextStyles.h4.copyWith(
              color: AppColors.primary,
            ),
          ),
          
          const SizedBox(height: 20),
          
          Text(
            'I believe in continuous learning and staying up-to-date with the latest technologies. Currently exploring AI/ML integration, advanced Flutter animations, and cloud architecture patterns.',
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 30),
          
          // Learning stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStat('3+', 'Years Experience'),
              _buildStat('50+', 'Projects Completed'),
              _buildStat('20+', 'Technologies Used'),
              _buildStat('∞', 'Learning Attitude'),
            ],
          ),
        ],
      ),
    ).animate()
      .fadeIn(delay: 800.ms, duration: 600.ms)
      .slideY(begin: 0.1, end: 0);
  }

  Widget _buildStat(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: AppTextStyles.h3.copyWith(
            color: AppColors.primary,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final SkillCategory category;
  final int index;

  const _SkillCategoryCard({
    required this.category,
    required this.index,
  });

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard>
    with TickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late List<AnimationController> _skillAnimationControllers;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _skillAnimationControllers = widget.category.skills.map((skill) {
      return AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
      );
    }).toList();
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (var controller in _skillAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startSkillAnimations() {
    for (int i = 0; i < _skillAnimationControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _skillAnimationControllers[i].forward();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
        _startSkillAnimations();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.background.withOpacity(0.9)
              : AppColors.background.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary.withOpacity(0.5)
                : AppColors.grey.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: FaIcon(
                    widget.category.icon,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                
                const SizedBox(width: 15),
                
                Expanded(
                  child: Text(
                    widget.category.title,
                    style: AppTextStyles.h4.copyWith(fontSize: 18),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 25),
            
            // Skills list
            Expanded(
              child: ListView.builder(
                itemCount: widget.category.skills.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: _SkillBar(
                      skill: widget.category.skills[index],
                      animationController: _skillAnimationControllers[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ).animate()
        .fadeIn(delay: Duration(milliseconds: 200 + (widget.index * 100)))
        .slideY(begin: 0.2, end: 0),
    );
  }
}

class _SkillBar extends StatelessWidget {
  final Skill skill;
  final AnimationController animationController;

  const _SkillBar({
    required this.skill,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill.name,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${skill.percentage}%',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(3),
          ),
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: animationController.value * (skill.percentage / 100),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SkillCategory {
  final String title;
  final IconData icon;
  final List<Skill> skills;

  SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });
}

class Skill {
  final String name;
  final int percentage;

  Skill(this.name, this.percentage);
}
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/section_title.dart';
import '../widgets/custom_button.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final List<Project> _projects = [
    Project(
      title: 'E-Commerce Flutter App',
      description: 'A full-featured e-commerce mobile application built with Flutter and Firebase. Includes user authentication, product catalog, shopping cart, and payment integration.',
      technologies: ['Flutter', 'Firebase', 'Stripe', 'Provider'],
      githubUrl: 'https://github.com/vivekjindal/ecommerce-app',
      liveUrl: 'https://play.google.com/store/apps/details?id=com.example.shop',
      category: ProjectCategory.mobile,
      featured: true,
    ),
    Project(
      title: 'Portfolio Website',
      description: 'A responsive portfolio website built with React and modern web technologies. Features smooth animations, dark/light theme toggle, and optimized performance.',
      technologies: ['React', 'TypeScript', 'Tailwind CSS', 'Framer Motion'],
      githubUrl: 'https://github.com/vivekjindal/portfolio',
      liveUrl: 'https://vivekjindal.dev',
      category: ProjectCategory.web,
      featured: true,
    ),
    Project(
      title: 'Task Management Dashboard',
      description: 'A comprehensive task management dashboard with real-time collaboration features. Built with React frontend and Node.js backend.',
      technologies: ['React', 'Node.js', 'MongoDB', 'Socket.io'],
      githubUrl: 'https://github.com/vivekjindal/task-manager',
      liveUrl: 'https://taskmanager.vivekjindal.dev',
      category: ProjectCategory.web,
      featured: false,
    ),
    Project(
      title: 'Weather App',
      description: 'A beautiful weather application with location-based forecasts, interactive maps, and customizable widgets. Available on iOS and Android.',
      technologies: ['Flutter', 'OpenWeather API', 'Maps', 'Animations'],
      githubUrl: 'https://github.com/vivekjindal/weather-app',
      liveUrl: 'https://apps.apple.com/app/weather-pro',
      category: ProjectCategory.mobile,
      featured: false,
    ),
    Project(
      title: 'Social Media Dashboard',
      description: 'A comprehensive social media analytics dashboard that aggregates data from multiple platforms with real-time insights and reporting.',
      technologies: ['Vue.js', 'Python', 'PostgreSQL', 'Chart.js'],
      githubUrl: 'https://github.com/vivekjindal/social-dashboard',
      liveUrl: 'https://dashboard.example.com',
      category: ProjectCategory.web,
      featured: false,
    ),
    Project(
      title: 'Fitness Tracking App',
      description: 'A comprehensive fitness tracking application with workout plans, progress monitoring, and community features. Integrates with wearable devices.',
      technologies: ['React Native', 'Firebase', 'HealthKit', 'Chart.js'],
      githubUrl: 'https://github.com/vivekjindal/fitness-app',
      liveUrl: 'https://fitness.vivekjindal.dev',
      category: ProjectCategory.mobile,
      featured: false,
    ),
  ];

  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Web', 'Mobile', 'Featured'];

  List<Project> get _filteredProjects {
    if (_selectedFilter == 'All') return _projects;
    if (_selectedFilter == 'Featured') return _projects.where((p) => p.featured).toList();
    if (_selectedFilter == 'Web') return _projects.where((p) => p.category == ProjectCategory.web).toList();
    if (_selectedFilter == 'Mobile') return _projects.where((p) => p.category == ProjectCategory.mobile).toList();
    return _projects;
  }

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
        children: [
          const SectionTitle(
            number: '03',
            title: 'Projects & Portfolio',
          ),
          
          const SizedBox(height: 40),
          
          // Filter buttons
          _buildFilterButtons(),
          
          const SizedBox(height: 60),
          
          // Projects grid
          _buildProjectsGrid(context, isMobile, isTablet),
          
          const SizedBox(height: 60),
          
          // View all projects button
          CustomButton(
            text: 'View All Projects on GitHub',
            onPressed: () async {
              final url = Uri.parse('https://github.com/vivekjindal');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
            variant: ButtonVariant.outlined,
            icon: FontAwesomeIcons.github,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Wrap(
      spacing: 15,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: _filters.map((filter) {
        bool isSelected = _selectedFilter == filter;
        return _FilterButton(
          text: filter,
          isSelected: isSelected,
          onTap: () {
            setState(() {
              _selectedFilter = filter;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, bool isMobile, bool isTablet) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: isMobile ? 0.9 : 0.8,
      ),
      itemCount: _filteredProjects.length,
      itemBuilder: (context, index) {
        return _ProjectCard(
          project: _filteredProjects[index],
          index: index,
        );
      },
    );
  }
}

class _FilterButton extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<_FilterButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isSelected || _isHovered
                ? AppColors.primary.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: widget.isSelected
                  ? AppColors.primary
                  : (_isHovered ? AppColors.primary : AppColors.grey.withOpacity(0.3)),
              width: 2,
            ),
          ),
          child: Text(
            widget.text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: widget.isSelected || _isHovered
                  ? AppColors.primary
                  : AppColors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final int index;

  const _ProjectCard({
    required this.project,
    required this.index,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.8),
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
            // Project image placeholder
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.background.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    AppColors.surface.withOpacity(0.1),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          widget.project.category == ProjectCategory.web
                              ? Icons.web
                              : Icons.phone_android,
                          size: 48,
                          color: AppColors.primary.withOpacity(0.6),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Project Preview',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.project.featured)
                    Positioned(
                      top: 15,
                      right: 15,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Featured',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.background,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Project content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project title
                    Text(
                      widget.project.title,
                      style: AppTextStyles.h4.copyWith(fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // Project description
                    Expanded(
                      child: Text(
                        widget.project.description,
                        style: AppTextStyles.bodySmall,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                    
                    // Technologies
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.project.technologies.take(3).map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.3),
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            tech,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Project links
                    Row(
                      children: [
                        Expanded(
                          child: _ProjectLinkButton(
                            icon: FontAwesomeIcons.github,
                            onPressed: () => _launchUrl(widget.project.githubUrl),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _ProjectLinkButton(
                            icon: FontAwesomeIcons.externalLinkAlt,
                            onPressed: () => _launchUrl(widget.project.liveUrl),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).animate()
        .fadeIn(delay: Duration(milliseconds: 200 + (widget.index * 100)))
        .slideY(begin: 0.2, end: 0),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _ProjectLinkButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _ProjectLinkButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_ProjectLinkButton> createState() => _ProjectLinkButtonState();
}

class _ProjectLinkButtonState extends State<_ProjectLinkButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 40,
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary
                  : AppColors.grey.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? AppColors.primary : AppColors.grey,
            size: 18,
          ),
        ),
      ),
    );
  }
}

enum ProjectCategory { web, mobile }

class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final String githubUrl;
  final String liveUrl;
  final ProjectCategory category;
  final bool featured;

  Project({
    required this.title,
    required this.description,
    required this.technologies,
    required this.githubUrl,
    required this.liveUrl,
    required this.category,
    required this.featured,
  });
}
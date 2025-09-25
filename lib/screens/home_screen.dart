import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../widgets/navigation_bar.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/projects_section.dart';
import '../sections/contact_section.dart';
import '../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AutoScrollController _scrollController;
  int _currentSectionIndex = 0;

  final List<String> _sectionTitles = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = AutoScrollController(
      viewportBoundaryGetter: () => 
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );
    
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Simple section tracking based on scroll position
    double scrollPosition = _scrollController.offset;
    double screenHeight = MediaQuery.of(context).size.height;
    
    int newIndex = (scrollPosition / screenHeight).round();
    if (newIndex != _currentSectionIndex && newIndex >= 0 && newIndex < _sectionTitles.length) {
      setState(() {
        _currentSectionIndex = newIndex;
      });
    }
  }

  void _scrollToSection(int index) {
    _scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Stack(
          children: [
            // Main content
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  AutoScrollTag(
                    key: ValueKey(0),
                    controller: _scrollController,
                    index: 0,
                    child: const HeroSection(),
                  ),
                  AutoScrollTag(
                    key: ValueKey(1),
                    controller: _scrollController,
                    index: 1,
                    child: const AboutSection(),
                  ),
                  AutoScrollTag(
                    key: ValueKey(2),
                    controller: _scrollController,
                    index: 2,
                    child: const SkillsSection(),
                  ),
                  AutoScrollTag(
                    key: ValueKey(3),
                    controller: _scrollController,
                    index: 3,
                    child: const ProjectsSection(),
                  ),
                  AutoScrollTag(
                    key: ValueKey(4),
                    controller: _scrollController,
                    index: 4,
                    child: const ContactSection(),
                  ),
                ],
              ),
            ),
            // Navigation bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomNavigationBar(
                currentIndex: _currentSectionIndex,
                sections: _sectionTitles,
                onTap: _scrollToSection,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_colors.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  final List<SocialLink> _links = const [
    SocialLink(
      icon: FontAwesomeIcons.github,
      url: 'https://github.com/vivekjindal',
      label: 'GitHub',
    ),
    SocialLink(
      icon: FontAwesomeIcons.linkedin,
      url: 'https://linkedin.com/in/vivekjindal',
      label: 'LinkedIn',
    ),
    SocialLink(
      icon: FontAwesomeIcons.twitter,
      url: 'https://twitter.com/vivekjindal',
      label: 'Twitter',
    ),
    SocialLink(
      icon: FontAwesomeIcons.instagram,
      url: 'https://instagram.com/vivekjindal',
      label: 'Instagram',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _links.map((link) {
        return Padding(
          padding: const EdgeInsets.only(right: 20),
          child: _SocialButton(link: link),
        );
      }).toList(),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final SocialLink link;

  const _SocialButton({required this.link});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
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

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(widget.link.url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
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
      child: GestureDetector(
        onTap: _launchUrl,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: 45,
            height: 45,
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
              widget.link.icon,
              color: _isHovered ? AppColors.primary : AppColors.grey,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class SocialLink {
  final IconData icon;
  final String url;
  final String label;

  const SocialLink({
    required this.icon,
    required this.url,
    required this.label,
  });
}
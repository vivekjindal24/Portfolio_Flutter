import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/section_title.dart';
import '../widgets/custom_button.dart';
import '../widgets/social_links.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate form submission
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isSubmitting = false;
      });

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Message sent successfully!'),
            backgroundColor: AppColors.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    }
  }

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
            number: '04',
            title: 'Get In Touch',
            centerAlign: true,
          ),
          
          const SizedBox(height: 40),
          
          // Introduction
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'I\'m always interested in new opportunities and exciting projects. Whether you have a question, want to collaborate, or just want to say hi, I\'d love to hear from you!',
              style: AppTextStyles.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ).animate()
            .fadeIn(delay: 200.ms, duration: 600.ms),
          
          const SizedBox(height: 60),
          
          // Contact content
          isMobile
              ? Column(
                  children: [
                    _buildContactForm(),
                    const SizedBox(height: 40),
                    _buildContactInfo(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildContactForm(),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      flex: 2,
                      child: _buildContactInfo(),
                    ),
                  ],
                ),
          
          const SizedBox(height: 80),
          
          // Footer
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Send me a message',
              style: AppTextStyles.h4.copyWith(
                color: AppColors.primary,
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Name and Email row
            Row(
              children: [
                Expanded(
                  child: _CustomTextField(
                    controller: _nameController,
                    label: 'Name',
                    hint: 'Your full name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _CustomTextField(
                    controller: _emailController,
                    label: 'Email',
                    hint: 'your.email@example.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Subject
            _CustomTextField(
              controller: _subjectController,
              label: 'Subject',
              hint: 'What is this about?',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a subject';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Message
            _CustomTextField(
              controller: _messageController,
              label: 'Message',
              hint: 'Tell me more about your project or question...',
              maxLines: 6,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                if (value.length < 10) {
                  return 'Message should be at least 10 characters long';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 30),
            
            // Submit button
            CustomButton(
              text: _isSubmitting ? 'Sending...' : 'Send Message',
              onPressed: _isSubmitting ? () {} : _submitForm,
              isLoading: _isSubmitting,
              variant: ButtonVariant.filled,
              icon: FontAwesomeIcons.paperPlane,
            ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(delay: 400.ms, duration: 600.ms)
      .slideX(begin: -0.1, end: 0);
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let\'s connect',
          style: AppTextStyles.h4,
        ),
        
        const SizedBox(height: 20),
        
        Text(
          'Feel free to reach out through any of these channels. I typically respond within 24 hours.',
          style: AppTextStyles.bodyMedium,
        ),
        
        const SizedBox(height: 40),
        
        // Contact methods
        _ContactMethod(
          icon: FontAwesomeIcons.envelope,
          title: 'Email',
          subtitle: 'vivek.jindal@example.com',
          onTap: () => _launchUrl('mailto:vivek.jindal@example.com'),
        ),
        
        const SizedBox(height: 20),
        
        _ContactMethod(
          icon: FontAwesomeIcons.phone,
          title: 'Phone',
          subtitle: '+91 9876543210',
          onTap: () => _launchUrl('tel:+919876543210'),
        ),
        
        const SizedBox(height: 20),
        
        _ContactMethod(
          icon: FontAwesomeIcons.mapMarkerAlt,
          title: 'Location',
          subtitle: 'India',
          onTap: () {},
        ),
        
        const SizedBox(height: 40),
        
        // Social links
        Text(
          'Follow me on',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        
        const SizedBox(height: 15),
        
        const SocialLinks(),
        
        const SizedBox(height: 40),
        
        // Response time info
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.clock,
                    color: AppColors.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Quick Response',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              Text(
                'I aim to respond to all messages within 24 hours. For urgent matters, feel free to call or message me directly.',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),
      ],
    ).animate()
      .fadeIn(delay: 600.ms, duration: 600.ms)
      .slideX(begin: 0.1, end: 0);
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                AppColors.primary.withOpacity(0.3),
                Colors.transparent,
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 40),
        
        Text(
          '© 2024 Vivek Jindal. Built with Flutter 💙',
          style: AppTextStyles.bodySmall,
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 20),
        
        // Back to top button
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              // TODO: Implement scroll to top
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                FontAwesomeIcons.chevronUp,
                color: AppColors.primary,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    ).animate()
      .fadeIn(delay: 800.ms, duration: 600.ms);
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;

  const _CustomTextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  State<_CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<_CustomTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.accent,
          ),
        ),
        
        const SizedBox(height: 8),
        
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          onTap: () => setState(() => _isFocused = true),
          onFieldSubmitted: (_) => setState(() => _isFocused = false),
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.white,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.grey.withOpacity(0.7),
            ),
            filled: true,
            fillColor: AppColors.surface.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.grey.withOpacity(0.3),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.grey.withOpacity(0.3),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactMethod extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactMethod({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  State<_ContactMethod> createState() => _ContactMethodState();
}

class _ContactMethodState extends State<_ContactMethod> {
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary.withOpacity(0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withOpacity(0.3)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  widget.icon,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              
              const SizedBox(width: 15),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
                      ),
                    ),
                    Text(
                      widget.subtitle,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
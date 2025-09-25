# Vivek Jindal - Portfolio Website

A modern, responsive portfolio website built with Flutter for web, featuring smooth animations, interactive elements, and a sleek dark theme design.

## 🌟 Features

- **Responsive Design**: Optimized for desktop, tablet, and mobile devices
- **Modern UI**: Dark theme with cyan accent colors and smooth animations
- **Interactive Elements**: Hover effects, animations, and micro-interactions
- **Section Navigation**: Smooth scrolling between portfolio sections
- **Contact Form**: Functional contact form with validation
- **Social Integration**: Links to GitHub, LinkedIn, and other social platforms
- **PWA Ready**: Progressive Web App capabilities for mobile installation

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/
│   └── home_screen.dart     # Main home screen with navigation
├── sections/                # Portfolio sections
│   ├── hero_section.dart    # Landing/intro section
│   ├── about_section.dart   # About me section
│   ├── skills_section.dart  # Skills and expertise
│   ├── projects_section.dart # Portfolio projects
│   └── contact_section.dart # Contact form and info
├── widgets/                 # Reusable UI components
│   ├── navigation_bar.dart  # Top navigation bar
│   ├── custom_button.dart   # Custom button component
│   ├── section_title.dart   # Section title component
│   └── social_links.dart    # Social media links
└── utils/                   # Utilities and constants
    ├── app_colors.dart      # Color scheme
    └── app_text_styles.dart # Typography styles
```

## 🎨 Design Features

### Color Scheme
- **Background**: Dark navy gradient (`#0A192F` to `#020C1B`)
- **Primary**: Cyan (`#64FFDA`)
- **Text**: Light grey (`#8892B0`) and white (`#FFFFFF`)
- **Accent**: Various shades for depth and hierarchy

### Sections
1. **Hero Section**: Name, animated role text, and call-to-action buttons
2. **About Section**: Personal introduction, highlights, and technology stack
3. **Skills Section**: Interactive skill categories with animated progress bars
4. **Projects Section**: Filterable project showcase with GitHub/live links
5. **Contact Section**: Contact form and social media integration

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Web browser for testing
- Code editor (VS Code recommended)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/vivekjindal/portfolio
   cd portfolio
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the development server**
   ```bash
   flutter run -d chrome
   ```

### Building for Production

1. **Build for web**
   ```bash
   flutter build web --release
   ```

2. **Deploy to hosting platform**
   - The built files will be in `build/web/` directory
   - Deploy to Firebase Hosting, Netlify, Vercel, or any static hosting service

## 📱 Responsive Breakpoints

- **Mobile**: 0px - 450px
- **Tablet**: 451px - 800px  
- **Desktop**: 801px - 1920px
- **4K**: 1921px+

## 🔧 Customization

### Personal Information
Update the following files with your information:
- `lib/sections/hero_section.dart` - Name and introduction
- `lib/sections/about_section.dart` - About content and technologies
- `lib/sections/skills_section.dart` - Skills and proficiency levels
- `lib/sections/projects_section.dart` - Project portfolio
- `lib/sections/contact_section.dart` - Contact information

### Styling
- Modify colors in `lib/utils/app_colors.dart`
- Adjust typography in `lib/utils/app_text_styles.dart`
- Update animations and transitions throughout components

### Assets
Replace placeholder assets:
- Profile photo in about section
- Project screenshots/images
- Social media profile links
- Resume/CV download link

## 📦 Dependencies

- `flutter`: SDK
- `google_fonts`: Typography
- `font_awesome_flutter`: Icons
- `url_launcher`: External links
- `animated_text_kit`: Text animations
- `flutter_animate`: General animations
- `responsive_framework`: Responsive design
- `scroll_to_index`: Section navigation

## 🚀 Deployment Options

### Firebase Hosting
```bash
npm install -g firebase-tools
firebase init hosting
flutter build web
firebase deploy
```

### Netlify
- Connect your GitHub repository
- Build command: `flutter build web`
- Publish directory: `build/web`

### Vercel
- Import from GitHub
- Framework preset: Other
- Build command: `flutter build web`
- Output directory: `build/web`

## 📈 Performance Features

- **Lazy loading**: Sections load as needed
- **Optimized animations**: Smooth 60fps animations
- **Responsive images**: Proper sizing for different devices
- **Code splitting**: Efficient bundle loading
- **PWA features**: Offline support and app-like experience

## 🎯 SEO Optimization

- Meta tags for search engines
- Open Graph tags for social sharing
- Structured data markup
- Semantic HTML elements
- Performance optimizations

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📞 Contact

**Vivek Jindal**
- Email: vivek.jindal@example.com
- LinkedIn: [linkedin.com/in/vivekjindal](https://linkedin.com/in/vivekjindal)
- GitHub: [github.com/vivekjindal](https://github.com/vivekjindal)
- Website: [vivekjindal.dev](https://vivekjindal.dev)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Google Fonts for beautiful typography
- Font Awesome for comprehensive icons
- Figma community for design inspiration
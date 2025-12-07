import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/static_data_service.dart';
import '../widgets/projects_section.dart';
import '../widgets/loading_widget.dart';
import '../widgets/footer_section.dart';
import '../models/personal_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  late final personalInfo = StaticDataService.getPersonalInfo();
  late final projects = StaticDataService.getProjects();

  @override
  void initState() {
    super.initState();
    // Simulate loading for better UX
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingWidget();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color(0xFFD4AF37).withOpacity(0.2), // Subtle gold border
                      width: 1,
                    ),
                  ),
                ),
              ),
              title: Text(
                'Rosangela Herrera\'s Portfolio',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFB8860B), // Gold color
                  letterSpacing: 0.5,
                ),
              ),
              centerTitle: true,
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section - Name, Title, Location, Contact
                  _HeaderSection(personalInfo: personalInfo),
                  const SizedBox(height: 40),
                  // Projects Section
                  ProjectsSection(projects: projects),
                  const SizedBox(height: 40),
                  // About Me Section (Bio only)
                  _AboutMeSection(personalInfo: personalInfo),
                  const SizedBox(height: 40),
                  // Footer Section
                  FooterSection(personalInfo: personalInfo),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Header Section with Name, Title, Location, and Contact Info
class _HeaderSection extends StatelessWidget {
  final PersonalInfo personalInfo;

  const _HeaderSection({required this.personalInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Picture
          if (personalInfo.imagePath != null)
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  personalInfo.imagePath!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF6A1B9A), // Purple
                            Color(0xFFD4AF37), // Gold
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          personalInfo.name.isNotEmpty
                              ? personalInfo.name[0].toUpperCase()
                              : '?',
                          style: GoogleFonts.inter(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          // Info Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  personalInfo.title,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: const Color(0xFF6A1B9A), // Purple
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                // Contact Info
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    if (personalInfo.email != null)
                      _ContactItem(
                        icon: Icons.email_outlined,
                        text: personalInfo.email,
                        onTap: () async {
                          final uri = Uri(scheme: 'mailto', path: personalInfo.email);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        },
                      ),
                    if (personalInfo.phone != null)
                      _ContactItem(
                        icon: Icons.phone_outlined,
                        text: personalInfo.phone!,
                        onTap: () async {
                          final uri = Uri(scheme: 'tel', path: personalInfo.phone);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        },
                      ),
                    if (personalInfo.githubUrl != null)
                      _ContactItem(
                        icon: FontAwesomeIcons.github,
                        text: 'GitHub',
                        isFontAwesome: true,
                        onTap: () async {
                          String url = personalInfo.githubUrl!;
                          // Add https:// if missing
                          if (!url.startsWith('http://') && !url.startsWith('https://')) {
                            url = 'https://$url';
                          }
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          }
                        },
                      ),
                    if (personalInfo.linkedinUrl != null)
                      _ContactItem(
                        icon: FontAwesomeIcons.linkedin,
                        text: 'LinkedIn',
                        isFontAwesome: true,
                        onTap: () async {
                          String url = personalInfo.linkedinUrl!;
                          // Add https:// if missing
                          if (!url.startsWith('http://') && !url.startsWith('https://')) {
                            url = 'https://$url';
                          }
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          }
                        },
                      ),
                  ],
                ),
                // Location
                if (personalInfo.location != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        personalInfo.location!,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool isFontAwesome;

  const _ContactItem({
    required this.icon,
    required this.text,
    required this.onTap,
    this.isFontAwesome = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isFontAwesome)
            FaIcon(icon, color: const Color(0xFF6A1B9A), size: 18)
          else
            Icon(icon, color: const Color(0xFF6A1B9A), size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: const Color(0xFF6A1B9A),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// About Me Section (Bio only)
class _AboutMeSection extends StatelessWidget {
  final PersonalInfo personalInfo;

  const _AboutMeSection({required this.personalInfo});

  @override
  Widget build(BuildContext context) {
    if (personalInfo.bio == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Me',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            personalInfo.bio!,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/static_data_service.dart';
import '../widgets/projects_section.dart';
import '../widgets/ai_ml_notebooks_section.dart';
import '../widgets/loading_widget.dart';
import '../widgets/footer_section.dart';
import '../widgets/decorative_elements.dart';
import '../models/personal_info.dart';
import '../models/project.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  PersonalInfo get personalInfo => StaticDataService.getPersonalInfo();
  List<Project> get projects => StaticDataService.getProjects();
  List<Project> get aiMlNotebooks => StaticDataService.getAIMLNotebooks();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), () {
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: FloatingDecorations(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 48, 32, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _IntroSection(personalInfo: personalInfo),
                        const SizedBox(height: 56),
                        const DecorativeDivider(),
                        ProjectsSection(projects: projects),
                        const SizedBox(height: 56),
                        const DecorativeDivider(),
                        AIMLNotebooksSection(notebooks: aiMlNotebooks),
                        if (aiMlNotebooks.isNotEmpty) ...[
                          const SizedBox(height: 56),
                          const DecorativeDivider(),
                        ],
                        _AboutMeSection(personalInfo: personalInfo),
                        const SizedBox(height: 56),
                        const DecorativeDivider(),
                        FooterSection(personalInfo: personalInfo),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroSection extends StatelessWidget {
  final PersonalInfo personalInfo;

  const _IntroSection({required this.personalInfo});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 720;

        final textBlock = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.emerald,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              personalInfo.name,
              style: GoogleFonts.inter(
                fontSize: isCompact ? 32 : 40,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: -1,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              personalInfo.title,
              style: GoogleFonts.inter(
                fontSize: isCompact ? 16 : 18,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            if (personalInfo.location != null) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.textMuted,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    personalInfo.location!,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 28),
            Wrap(
              spacing: 20,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (personalInfo.email.isNotEmpty)
                  _IntroLink(
                    icon: const Icon(
                      Icons.email_outlined,
                      color: AppColors.emerald,
                      size: 16,
                    ),
                    label: personalInfo.email,
                    onTap: () async {
                      final uri = Uri(scheme: 'mailto', path: personalInfo.email);
                      if (await canLaunchUrl(uri)) await launchUrl(uri);
                    },
                  ),
                if (personalInfo.phone != null)
                  _IntroLink(
                    icon: const Icon(
                      Icons.phone_outlined,
                      color: AppColors.emerald,
                      size: 16,
                    ),
                    label: personalInfo.phone!,
                    onTap: () async {
                      final uri = Uri(scheme: 'tel', path: personalInfo.phone);
                      if (await canLaunchUrl(uri)) await launchUrl(uri);
                    },
                  ),
                if (personalInfo.githubUrl != null)
                  _IntroLink(
                    icon: const FaIcon(
                      FontAwesomeIcons.github,
                      color: AppColors.emerald,
                      size: 14,
                    ),
                    label: 'GitHub',
                    onTap: () => _launchExternal(personalInfo.githubUrl!),
                  ),
                if (personalInfo.linkedinUrl != null)
                  _IntroLink(
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: AppColors.emerald,
                      size: 14,
                    ),
                    label: 'LinkedIn',
                    onTap: () => _launchExternal(personalInfo.linkedinUrl!),
                  ),
              ],
            ),
          ],
        );

        final profilePhoto = personalInfo.imagePath != null
            ? Container(
                width: isCompact ? 112 : 140,
                height: isCompact ? 112 : 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.emerald.withOpacity(0.25),
                    width: 2,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x10059669),
                      blurRadius: 24,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    personalInfo.imagePath!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.emeraldMuted,
                        child: Center(
                          child: Text(
                            personalInfo.name.isNotEmpty
                                ? personalInfo.name[0].toUpperCase()
                                : '?',
                            style: GoogleFonts.inter(
                              fontSize: 48,
                              fontWeight: FontWeight.w600,
                              color: AppColors.emerald,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            : null;

        if (isCompact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (profilePhoto != null) ...[
                profilePhoto,
                const SizedBox(height: 28),
              ],
              textBlock,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: textBlock),
            if (profilePhoto != null) ...[
              const SizedBox(width: 48),
              profilePhoto,
            ],
          ],
        );
      },
    );
  }

  Future<void> _launchExternal(String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _IntroLink extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const _IntroLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.border,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      padding: const EdgeInsets.all(32),
      decoration: AppDecorations.card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'About Me'),
          const SizedBox(height: 20),
          ..._bioParagraphs(personalInfo.bio!),
        ],
      ),
    );
  }

  List<Widget> _bioParagraphs(String bio) {
    final paragraphs = bio
        .split(RegExp(r'\n\s*\n'))
        .map((paragraph) => paragraph.trim())
        .where((paragraph) => paragraph.isNotEmpty)
        .toList();

    return [
      for (int i = 0; i < paragraphs.length; i++) ...[
        Text(
          paragraphs[i],
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppColors.textSecondary,
            height: 1.7,
          ),
        ),
        if (i < paragraphs.length - 1) const SizedBox(height: 16),
      ],
    ];
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';
import '../theme/app_theme.dart';

class ProjectsSection extends StatelessWidget {
  final List<Project> projects;

  const ProjectsSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Featured Projects',
          subtitle: 'A selection of work spanning full-stack development, AI, and product design.',
        ),
        const SizedBox(height: 28),

        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 900 ? 2 : 1;
            final cardWidth = crossAxisCount == 2
                ? (constraints.maxWidth - 16) / 2
                : constraints.maxWidth;

            final rows = <List<Project>>[];
            for (int i = 0; i < projects.length; i += crossAxisCount) {
              rows.add(projects.sublist(
                  i,
                  i + crossAxisCount > projects.length
                      ? projects.length
                      : i + crossAxisCount));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rows.map((rowProjects) {
                return EqualHeightRow(
                  cardWidth: cardWidth,
                  spacing: 16,
                  children: rowProjects.map((project) {
                    return ProjectCard(project: project);
                  }).toList(),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: AppDecorations.card(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (project.underDevelopment)
                  const _StatusBadge(
                    label: 'In Progress',
                    background: AppColors.emeraldMuted,
                    foreground: AppColors.emerald,
                    outlined: true,
                  ),
                if (project.featured && !project.underDevelopment)
                  const _StatusBadge(
                    label: 'Featured',
                    background: AppColors.emerald,
                    foreground: Colors.white,
                  ),
              ],
            ),

            const SizedBox(height: 14),

            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  project.description,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.65,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: project.technologiesList.map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.emeraldMuted.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tech.trim(),
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppColors.emerald,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                if (project.githubUrl != null)
                  Expanded(
                    child: _buildActionButton(
                      icon: FontAwesomeIcons.github,
                      label: 'Code',
                      onTap: () => _launchUrl(project.githubUrl!),
                    ),
                  ),
                if (project.githubUrl != null &&
                    (project.liveUrl != null || project.fileUrl != null))
                  const SizedBox(width: 10),
                if (project.liveUrl != null)
                  Expanded(
                    child: _buildActionButton(
                      icon: FontAwesomeIcons.externalLinkAlt,
                      label: 'Live Demo',
                      onTap: () => _launchUrl(project.liveUrl!),
                      isPrimary: true,
                    ),
                  ),
                if (project.liveUrl != null && project.fileUrl != null)
                  const SizedBox(width: 10),
                if (project.fileUrl != null)
                  Expanded(
                    child: _buildActionButton(
                      icon: FontAwesomeIcons.download,
                      label: 'Download',
                      onTap: () => _launchUrl(project.fileUrl!),
                      isPrimary: project.liveUrl == null,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return Material(
      color: isPrimary ? AppColors.emerald : AppColors.background,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: isPrimary ? null : Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isPrimary ? Colors.white : AppColors.textSecondary,
                size: 13,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isPrimary ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;
  final bool outlined;

  const _StatusBadge({
    required this.label,
    required this.background,
    required this.foreground,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
        border: outlined ? Border.all(color: AppColors.emerald.withOpacity(0.4)) : null,
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: foreground,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class EqualHeightRow extends StatelessWidget {
  final List<Widget> children;
  final double cardWidth;
  final double spacing;

  const EqualHeightRow({
    required this.children,
    required this.cardWidth,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: spacing),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children.asMap().entries.map((entry) {
            final index = entry.key;
            final child = entry.value;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < children.length - 1 ? spacing : 0,
                ),
                child: child,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

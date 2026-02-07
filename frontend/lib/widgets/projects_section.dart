import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';

class ProjectsSection extends StatelessWidget {
  final List<Project> projects;

  const ProjectsSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Text(
          'Here are some of my favorite projects',
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF10B981), // Emerald
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 24),

        // Projects Grid - Using Wrap with equal height rows
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 900 ? 2 : 1;
            final cardWidth = crossAxisCount == 2
                ? (constraints.maxWidth - 16) / 2
                : constraints.maxWidth;

            // Group projects into rows
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
                    return SizedBox(
                      width: cardWidth,
                      child: ProjectCard(project: project),
                    );
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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Project Header
          Row(
            children: [
              Expanded(
                child: Text(
                  project.title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (project.underDevelopment)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF000000), // Black
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF10B981), // Emerald
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    'Under Development',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF10B981), // Emerald
                    ),
                  ),
                ),
              if (project.featured)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF10B981), // Emerald
                        Color(0xFF059669), // Dark Emerald
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Featured',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 6),

          // Project Description
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                project.description,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.black87,
                  height: 1.6,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Technologies
          // Wrap(
          //   spacing: 6,
          //   runSpacing: 6,
          //   children:
          //       project.technologiesList.take(5).map((tech) {
          //         return Container(
          //           padding: const EdgeInsets.symmetric(
          //             horizontal: 6,
          //             vertical: 3,
          //           ),
          //           decoration: BoxDecoration(
          //             color: Colors.white.withOpacity(0.1),
          //             borderRadius: BorderRadius.circular(6),
          //             border: Border.all(
          //               color: Colors.white.withOpacity(0.2),
          //               width: 1,
          //             ),
          //           ),
          //           child: Text(
          //             tech,
          //             style: GoogleFonts.inter(
          //               fontSize: 10,
          //               color: Colors.white70,
          //               fontWeight: FontWeight.w500,
          //             ),
          //           ),
          //         );
          //       }).toList(),
          // ),
          Wrap(
            spacing: 10, // Horizontal spacing between chips
            runSpacing: 10, // Vertical spacing when wrapping
            children: project.technologiesList.map((tech) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                margin: const EdgeInsets.only(
                    right: 4, bottom: 4), // Extra margin for separation
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1), // Light emerald background
                  borderRadius: BorderRadius.circular(10), // Pill shape
                  border: Border.all(
                    color: const Color(0xFF10B981), // Emerald border
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10B981).withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Text(
                  tech.trim(),
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFF059669), // Dark emerald text
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 12),

          // Project Images
          if (project.allImages.isNotEmpty) ...[
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: project.allImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    margin: EdgeInsets.only(
                      right: index < project.allImages.length - 1 ? 12 : 0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3), width: 1.5),
                      image: DecorationImage(
                        image: AssetImage(project.allImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Spacer to push button to bottom
          const Spacer(),

          // Action Buttons
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
              if (project.githubUrl != null && project.fileUrl != null)
                const SizedBox(width: 8),
              if (project.fileUrl != null)
                Expanded(
                  child: _buildActionButton(
                    icon: FontAwesomeIcons.download,
                    label: 'Download',
                    onTap: () => _launchUrl(project.fileUrl!),
                    isPrimary: true,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          gradient: isPrimary
              ? const LinearGradient(
                  colors: [
                    Color(0xFF10B981), // Emerald
                    Color(0xFF059669), // Dark Emerald
                  ],
                )
              : null,
          color: isPrimary
              ? null
              : const Color(0xFF10B981).withOpacity(0.1), // Light emerald
          borderRadius: BorderRadius.circular(8),
          border: isPrimary
              ? null
              : Border.all(
                  color: const Color(0xFF10B981).withOpacity(0.4), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
                  isPrimary ? Colors.white : const Color(0xFF10B981), // Emerald
              size: 14,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isPrimary
                    ? Colors.white
                    : const Color(0xFF10B981), // Emerald
              ),
            ),
          ],
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

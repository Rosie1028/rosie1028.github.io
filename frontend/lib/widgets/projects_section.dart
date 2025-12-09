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
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFB8860B), // Gold color
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 24),

        // Projects Grid
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 900 ? 2 : 1;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.start,
              children: projects.map((project) {
                return SizedBox(
                  width: crossAxisCount == 2
                      ? (constraints.maxWidth - 16) / 2
                      : constraints.maxWidth,
                  child: ProjectCard(project: project),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
              if (project.featured)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37).withOpacity(0.15), // Gold
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFD4AF37), // Gold
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Featured',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFB8860B), // Darker gold
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 6),

          // Project Description (fixed height)
          SizedBox(
            height: 80, // Fixed height for all descriptions
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
            children: project.technologiesList.take(5).map((tech) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                margin: const EdgeInsets.only(
                    right: 4, bottom: 4), // Extra margin for separation
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFFFF8E1), // Light gold background
                      const Color(0xFFFFF9C4), // Slightly darker gold
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10), // Pill shape
                  border: Border.all(
                    color: const Color(0xFFD4AF37), // Gold border
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.25),
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
                    color: const Color(0xFFB8860B), // Dark gold text
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
                      border: Border.all(color: Colors.grey.shade200),
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
              // if (project.githubUrl != null && project.liveUrl != null)
              //   const SizedBox(width: 8),
              // if (project.liveUrl != null)
              //   Expanded(
              //     child: _buildActionButton(
              //       icon: FontAwesomeIcons.externalLinkAlt,
              //       label: 'Details',
              //       onTap: () => _launchUrl(project.liveUrl!),
              //       isPrimary: true,
              //     ),
              //   ),
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
          color: isPrimary
              ? const Color(0xFF6A1B9A) // Purple
              : const Color(0xFF6A1B9A).withOpacity(0.1), // Light purple
          borderRadius: BorderRadius.circular(6),
          border: isPrimary
              ? null
              : Border.all(
                  color: const Color(0xFF6A1B9A).withOpacity(0.3), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
                  isPrimary ? Colors.white : const Color(0xFF6A1B9A), // Purple
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
                    : const Color(0xFF6A1B9A), // Purple
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

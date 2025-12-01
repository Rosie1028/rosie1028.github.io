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
          'Projects',
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Here are some of my recent projects',
          style: GoogleFonts.inter(fontSize: 16, color: Colors.black54),
        ),
        const SizedBox(height: 24),

        // Projects Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return ProjectCard(project: projects[index]);
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

          const SizedBox(height: 8),

          // Project Description
          Expanded(
            child: Text(
              project.description,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.black87,
                height: 1.6,
              ),
              textAlign: TextAlign.justify,
              //maxLines: 3,
              // overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(height: 12),

          // // Technologies
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
                  borderRadius: BorderRadius.circular(20), // Pill shape
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

          // const SizedBox(height: 5),

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

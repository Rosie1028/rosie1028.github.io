import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/project.dart';
import 'projects_section.dart'; // Reuse ProjectCard and EqualHeightRow

class ExcelProjectsSection extends StatelessWidget {
  final List<Project> excelProjects;

  const ExcelProjectsSection({super.key, required this.excelProjects});

  @override
  Widget build(BuildContext context) {
    if (excelProjects.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Text(
          'Excel Projects',
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
            for (int i = 0; i < excelProjects.length; i += crossAxisCount) {
              rows.add(excelProjects.sublist(
                  i,
                  i + crossAxisCount > excelProjects.length
                      ? excelProjects.length
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

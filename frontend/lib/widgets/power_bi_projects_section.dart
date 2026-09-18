import 'package:flutter/material.dart';
import '../models/project.dart';
import '../theme/app_theme.dart';
import 'projects_section.dart';

class PowerBIProjectsSection extends StatelessWidget {
  final List<Project> reports;

  const PowerBIProjectsSection({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    if (reports.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Power BI Projects',
          subtitle:
              'Interactive dashboards and reports that turn data into decisions.',
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 900 ? 2 : 1;
            final cardWidth = crossAxisCount == 2
                ? (constraints.maxWidth - 16) / 2
                : constraints.maxWidth;

            final rows = <List<Project>>[];
            for (int i = 0; i < reports.length; i += crossAxisCount) {
              rows.add(reports.sublist(
                  i,
                  i + crossAxisCount > reports.length
                      ? reports.length
                      : i + crossAxisCount));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rows.map((rowProjects) {
                return EqualHeightRow(
                  cardWidth: cardWidth,
                  spacing: 16,
                  children: rowProjects.map((project) {
                    return ProjectCard(
                      project: project,
                      liveUrlLabel: 'View Report',
                      fileUrlLabel: 'Download Report',
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

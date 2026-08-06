import 'package:flutter/material.dart';
import '../models/project.dart';
import '../theme/app_theme.dart';
import 'projects_section.dart';

class AIMLNotebooksSection extends StatelessWidget {
  final List<Project> notebooks;

  const AIMLNotebooksSection({super.key, required this.notebooks});

  @override
  Widget build(BuildContext context) {
    if (notebooks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'AI / ML Notebooks',
          subtitle: 'Exploratory machine learning work and model experiments.',
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 900 ? 2 : 1;
            final cardWidth = crossAxisCount == 2
                ? (constraints.maxWidth - 16) / 2
                : constraints.maxWidth;

            final rows = <List<Project>>[];
            for (int i = 0; i < notebooks.length; i += crossAxisCount) {
              rows.add(notebooks.sublist(
                  i,
                  i + crossAxisCount > notebooks.length
                      ? notebooks.length
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

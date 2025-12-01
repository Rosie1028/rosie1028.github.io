import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/static_data_service.dart';
import '../widgets/personal_info_card.dart';
import '../widgets/projects_section.dart';
import '../widgets/loading_widget.dart';
import '../widgets/footer_section.dart';

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
                'Portfolio',
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
                  // Personal Info Section
                  PersonalInfoCard(personalInfo: personalInfo),
                  const SizedBox(height: 40),
                  // Projects Section
                  ProjectsSection(projects: projects),
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

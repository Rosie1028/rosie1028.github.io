import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/personal_info.dart';

class PersonalInfoCard extends StatelessWidget {
  final PersonalInfo personalInfo;

  const PersonalInfoCard({super.key, required this.personalInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A1A), Color(0xFF2D2D2D)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Row(
            children: [
              // Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipOval(
                  child:
                      personalInfo.imagePath != null
                          ? Image.asset(
                            personalInfo.imagePath!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF6366F1),
                                      Color(0xFF8B5CF6),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    personalInfo.name.isNotEmpty
                                        ? personalInfo.name[0].toUpperCase()
                                        : '?',
                                    style: GoogleFonts.inter(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                          : Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                personalInfo.name.isNotEmpty
                                    ? personalInfo.name[0].toUpperCase()
                                    : '?',
                                style: GoogleFonts.inter(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                ),
              ),
              const SizedBox(width: 20),

              // Name and Title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      personalInfo.name,
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      personalInfo.title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: const Color(0xFF6366F1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (personalInfo.location != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            personalInfo.location!,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.grey,
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

          const SizedBox(height: 24),

          // Bio
          if (personalInfo.bio != null) ...[
            Text(
              personalInfo.bio!,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.white70,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Contact Info
          if (personalInfo.email.isNotEmpty) ...[
            _buildContactItem(
              icon: Icons.email_outlined,
              label: personalInfo.email,
              onTap: () => _launchEmail(personalInfo.email),
            ),
            const SizedBox(height: 12),
          ],

          if (personalInfo.phone != null) ...[
            _buildContactItem(
              icon: Icons.phone_outlined,
              label: personalInfo.phone!,
              onTap: () => _launchPhone(personalInfo.phone!),
            ),
            const SizedBox(height: 12),
          ],

          // Social Links
          if (personalInfo.githubUrl != null ||
              personalInfo.linkedinUrl != null ||
              personalInfo.websiteUrl != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                if (personalInfo.githubUrl != null)
                  _buildSocialButton(
                    icon: FontAwesomeIcons.github,
                    onTap: () => _launchUrl(personalInfo.githubUrl!),
                  ),
                if (personalInfo.linkedinUrl != null)
                  _buildSocialButton(
                    icon: FontAwesomeIcons.linkedin,
                    onTap: () => _launchUrl(personalInfo.linkedinUrl!),
                  ),
                if (personalInfo.websiteUrl != null)
                  _buildSocialButton(
                    icon: FontAwesomeIcons.globe,
                    onTap: () => _launchUrl(personalInfo.websiteUrl!),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF6366F1), size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(fontSize: 14, color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        ),
        child: Icon(icon, color: Colors.white70, size: 20),
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

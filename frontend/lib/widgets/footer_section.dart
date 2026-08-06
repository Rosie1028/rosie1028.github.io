import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/personal_info.dart';
import '../theme/app_theme.dart';

class FooterSection extends StatefulWidget {
  const FooterSection({super.key, required this.personalInfo});

  final PersonalInfo personalInfo;

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (!(_formKey.currentState?.validate() ?? false)) {
      messenger?.showSnackBar(
        const SnackBar(
          content: Text('Please complete the form before sending.'),
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() => _isSending = true);

    try {
      final name = _nameCtrl.text.trim();
      final email = _emailCtrl.text.trim();
      final message = _messageCtrl.text.trim();
      final subject = 'Portfolio Contact: Message from $name';
      final body = 'Name: $name\nEmail: $email\n\nMessage:\n$message';

      final mailtoUrl =
          'mailto:${widget.personalInfo.email}?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';
      final uri = Uri.parse(mailtoUrl);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        _nameCtrl.clear();
        _emailCtrl.clear();
        _messageCtrl.clear();

        messenger?.showSnackBar(
          const SnackBar(
            content: Text('Opening your email client...'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        messenger?.showSnackBar(
          const SnackBar(
            content: Text('Unable to open email client. Please email directly.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      messenger?.showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() => _isSending = false);
    }
  }

  Future<void> _handleDownloadCv() async {
    final url = widget.personalInfo.resumeUrl;
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('CV link is not available yet.')),
      );
      return;
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Unable to open the CV link.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: AppDecorations.card(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 900;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Get in Touch',
                subtitle: 'Send a message or download my resume.',
              ),
              const SizedBox(height: 32),
              Flex(
                direction: isSmall ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _ContactForm(
                      formKey: _formKey,
                      nameCtrl: _nameCtrl,
                      emailCtrl: _emailCtrl,
                      messageCtrl: _messageCtrl,
                      isSending: _isSending,
                      onSubmit: _handleSubmit,
                    ),
                  ),
                  SizedBox(width: isSmall ? 0 : 40, height: isSmall ? 32 : 0),
                  Expanded(
                    child: _FooterDetails(
                      personalInfo: widget.personalInfo,
                      onDownloadCv: _handleDownloadCv,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  const _ContactForm({
    required this.formKey,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.messageCtrl,
    required this.isSending,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController messageCtrl;
  final bool isSending;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameCtrl,
            style: GoogleFonts.inter(color: AppColors.textPrimary),
            decoration: AppDecorations.textField('Your name'),
            validator: (value) =>
                value == null || value.trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            style: GoogleFonts.inter(color: AppColors.textPrimary),
            decoration: AppDecorations.textField('Email'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Required';
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
              if (!emailRegex.hasMatch(value.trim())) return 'Invalid email';
              return null;
            },
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: messageCtrl,
            minLines: 4,
            maxLines: 6,
            style: GoogleFonts.inter(color: AppColors.textPrimary),
            decoration: AppDecorations.textField('Message'),
            validator: (value) =>
                value == null || value.trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isSending ? null : onSubmit,
              icon: const Icon(Icons.send_outlined, size: 18),
              label: Text(isSending ? 'Sending...' : 'Send message'),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterDetails extends StatelessWidget {
  const _FooterDetails({
    required this.personalInfo,
    required this.onDownloadCv,
  });

  final PersonalInfo personalInfo;
  final VoidCallback onDownloadCv;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resume',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Download a copy of my CV to learn more about my experience and skills.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: onDownloadCv,
            icon: const Icon(Icons.download_outlined, size: 18),
            label: const Text('Download CV'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: const BorderSide(color: AppColors.emerald, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Prefer email?',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          SelectableText(
            personalInfo.email,
            style: GoogleFonts.inter(
              color: AppColors.emerald,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

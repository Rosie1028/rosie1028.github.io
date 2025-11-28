import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/personal_info.dart';

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
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isSending = false);

    _nameCtrl.clear();
    _emailCtrl.clear();
    _messageCtrl.clear();

    messenger?.showSnackBar(
      const SnackBar(
        content: Text('Thanks for reaching out! I’ll get back to you shortly.'),
      ),
    );
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

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      labelStyle: const TextStyle(color: Colors.white70),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.tealAccent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 48),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white10),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 900;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Let’s build something together',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Send me a quick message or grab a copy of my CV.',
                style: GoogleFonts.inter(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 32),
              Flex(
                direction: isSmall ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _ContactForm(
                      formKey: _formKey,
                      nameCtrl: _nameCtrl,
                      emailCtrl: _emailCtrl,
                      messageCtrl: _messageCtrl,
                      fieldDecorationBuilder: _fieldDecoration,
                      isSending: _isSending,
                      onSubmit: _handleSubmit,
                    ),
                  ),
                  SizedBox(width: isSmall ? 0 : 32, height: isSmall ? 32 : 0),
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
    required this.fieldDecorationBuilder,
    required this.isSending,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController messageCtrl;
  final InputDecoration Function(String label) fieldDecorationBuilder;
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
            style: const TextStyle(color: Colors.white),
            decoration: fieldDecorationBuilder('Your name'),
            validator:
                (value) =>
                    value == null || value.trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: fieldDecorationBuilder('Email'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Required';
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
              if (!emailRegex.hasMatch(value.trim())) return 'Invalid email';
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: messageCtrl,
            minLines: 4,
            maxLines: 6,
            style: const TextStyle(color: Colors.white),
            decoration: fieldDecorationBuilder('Message'),
            validator:
                (value) =>
                    value == null || value.trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isSending ? null : onSubmit,
              icon: const Icon(Icons.send),
              label: Text(isSending ? 'Sending...' : 'Send message'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.tealAccent.withOpacity(0.2),
                foregroundColor: Colors.white,
              ),
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
 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: onDownloadCv,
          icon: const Icon(Icons.download),
          label: const Text('Download CV'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.tealAccent.withOpacity(0.2),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Prefer email? Drop me a line at',
          style: GoogleFonts.inter(color: Colors.white70),
        ),
        Text(
          personalInfo.email,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}


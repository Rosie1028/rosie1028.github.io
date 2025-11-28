class PersonalInfo {
  final String name;
  final String title;
  final String email;
  final String? phone;
  final String? location;
  final String? bio;
  final String? linkedinUrl;
  final String? githubUrl;
  final String? websiteUrl;
  final String? imagePath;
  final String? resumeUrl;

  PersonalInfo({
    required this.name,
    required this.title,
    required this.email,
    this.phone,
    this.location,
    this.bio,
    this.linkedinUrl,
    this.githubUrl,
    this.websiteUrl,
    this.imagePath,
    this.resumeUrl,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      name: json['name'],
      title: json['title'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      bio: json['bio'],
      linkedinUrl: json['linkedin_url'],
      githubUrl: json['github_url'],
      websiteUrl: json['website_url'],
      imagePath: json['image_path'],
      resumeUrl: json['resume_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'email': email,
      'phone': phone,
      'location': location,
      'bio': bio,
      'linkedin_url': linkedinUrl,
      'github_url': githubUrl,
      'website_url': websiteUrl,
      'image_path': imagePath,
      'resume_url': resumeUrl,
    };
  }
}

class Project {
  final int id;
  final String title;
  final String description;
  final String technologies;
  final String? githubUrl;
  final String? liveUrl;
  final String? imageUrl;
  final List<String>? imageUrls;
  final bool featured;
  final String createdAt;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    this.imageUrl,
    this.imageUrls,
    required this.featured,
    required this.createdAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      technologies: json['technologies'],
      githubUrl: json['github_url'],
      liveUrl: json['live_url'],
      imageUrl: json['image_url'],
      imageUrls: json['image_urls'] != null 
          ? List<String>.from(json['image_urls'])
          : null,
      featured: json['featured'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'technologies': technologies,
      'github_url': githubUrl,
      'live_url': liveUrl,
      'image_url': imageUrl,
      'image_urls': imageUrls,
      'featured': featured,
      'created_at': createdAt,
    };
  }
  
  // Get all images (from imageUrls list or single imageUrl)
  List<String> get allImages {
    if (imageUrls != null && imageUrls!.isNotEmpty) {
      return imageUrls!;
    }
    if (imageUrl != null) {
      return [imageUrl!];
    }
    return [];
  }

  List<String> get technologiesList {
    // Split by comma and newline, then clean up each technology
    return technologies
        .split(RegExp(r'[,\n]')) // Split by comma or newline
        .map((tech) => tech.trim()) // Remove whitespace
        .where((tech) => tech.isNotEmpty) // Remove empty strings
        .map((tech) {
          // Remove prefixes like "Frontend:", "Backend:", etc.
          final colonIndex = tech.indexOf(':');
          if (colonIndex > 0 && colonIndex < tech.length - 1) {
            return tech.substring(colonIndex + 1).trim();
          }
          return tech;
        })
        .toList();
  }
}

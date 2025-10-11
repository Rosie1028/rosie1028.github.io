class Project {
  final int id;
  final String title;
  final String description;
  final String technologies;
  final String? githubUrl;
  final String? liveUrl;
  final String? imageUrl;
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
      'featured': featured,
      'created_at': createdAt,
    };
  }

  List<String> get technologiesList {
    return technologies.split(',').map((tech) => tech.trim()).toList();
  }
}

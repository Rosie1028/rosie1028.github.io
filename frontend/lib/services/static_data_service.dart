import '../models/personal_info.dart';
import '../models/project.dart';

class StaticDataService {
  static PersonalInfo getPersonalInfo() {
    return PersonalInfo(
      name: "Rosangela Herrera",
      title: "Full Stack Developer",
      email: "rosangelahs@icloud.com",
      phone: "+1 (561) 574-4947",
      location: "Austin, TX",
      bio:
          "Passionate full-stack developer with experience in Flutter, Python and AI. I love creating beautiful, functional applications that solve real-world problems and make my life and people's lives easier. I would love to work on projects that make a difference in the world.",
      linkedinUrl: "https://linkedin.com/in/rosangela-herrera",
      githubUrl: "https://github.com/rosangela-herrera",
      websiteUrl: "https://rosangelaherrera.dev",
      imagePath: "images/IMG_8959.jpg",
    );
  }

  static List<Project> getProjects() {
    return [
      Project(
        id: 1,
        title: "E-Commerce Mobile App",
        description:
            "A full-featured e-commerce mobile application built with Flutter. Features include user authentication, product catalog, shopping cart, and payment integration.",
        technologies: "Flutter, Dart, Firebase, Stripe API",
        githubUrl: "https://github.com/rosangela-herrera/ecommerce-app",
        liveUrl:
            "https://play.google.com/store/apps/details?id=com.example.ecommerce",
        featured: true,
        createdAt: "2024-01-15T10:30:00Z",
      ),
      Project(
        id: 2,
        title: "Task Management Dashboard",
        description:
            "A modern web-based task management dashboard built with React and Node.js. Features include team collaboration, project tracking, and real-time notifications.",
        technologies: "React, TypeScript, Node.js, PostgreSQL",
        githubUrl: "https://github.com/rosangela-herrera/task-dashboard",
        liveUrl: "https://taskdashboard.rosangelaherrera.dev",
        featured: true,
        createdAt: "2024-01-10T14:20:00Z",
      ),
      Project(
        id: 3,
        title: "Weather Analytics App",
        description:
            "A comprehensive weather analytics application that provides detailed forecasts and historical data analysis. Built with Flutter and integrated with weather APIs.",
        technologies: "Flutter, Dart, Weather API, Charts",
        githubUrl: "https://github.com/rosangela-herrera/weather-analytics",
        liveUrl: "https://weather.rosangelaherrera.dev",
        featured: false,
        createdAt: "2024-01-05T09:15:00Z",
      ),
      Project(
        id: 4,
        title: "Recipe Sharing Platform",
        description:
            "A social platform for sharing and discovering recipes. Users can create profiles, share recipes, rate dishes, and follow other food enthusiasts.",
        technologies: "React, Node.js, MongoDB, AWS S3",
        githubUrl: "https://github.com/rosangela-herrera/recipe-platform",
        liveUrl: "https://recipes.rosangelaherrera.dev",
        featured: true,
        createdAt: "2023-12-20T16:45:00Z",
      ),
    ];
  }

  static List<Project> getFeaturedProjects() {
    return getProjects().where((project) => project.featured).toList();
  }
}

import '../models/personal_info.dart';
import '../models/project.dart';

class StaticDataService {
  static PersonalInfo getPersonalInfo() {
    return PersonalInfo(
      name: "Rosangela Herrera",
      title:
          "Data Analyst | AI Developer | Educator | Exploring AI for Learning & Wellbeing",
      email: "rosangelahs@icloud.com",
      phone: "+1 (561) 574-4947",
      location: "Austin, TX",
      bio:
          """- I’m a Software Engineer with a background in software development, customer service, sales, and education. 
- I am passionate about exploring how artificial intelligence can be applied across different fields to improve learning, well-being, and human development. 
- My journey into technology is driven by curiosity and a commitment to creating solutions that are practical, inclusive, and genuinely helpful. 
- I aim to use technology thoughtfully, empowering people, enriching lives, and supporting growth without excess or distraction. 
- I design wellbeing-centered solutions that solve real problems.""",
      linkedinUrl:
          "https://www.linkedin.com/in/rosangela-herrera-suarez-a22759217",
      githubUrl: "https://github.com/Rosie1028",
      websiteUrl: "https://rosangelaherrera.dev",
      imagePath: "images/IMG_8959.jpg",
      resumeUrl:
          "https://drive.google.com/uc?export=download&id=16oYJz0puaqjSlyPr6i5edZEEgEW2OEN4",
    );
  }

  static List<Project> getProjects() {
    return [
      Project(
        id: 1,
        title: "National News Summarizer",
        description:
            "National News Summarizer is a full-stack application developed as my final thesis project during my Bachelor's degree. "
            'The project explores the power of Natural Language Processing (NLP) to automatically generate concise summaries from long-form '
            'news articles. It integrates a custom pipeline based on the NASES architecture and provides a user-friendly interface for real-time '
            'summarization.To support this system, I scraped and compiled a dataset of Cuban news articles and their corresponding '
            'summaries, which I published on Kaggle: Cuban News Dataset. Although I did not complete fine-tuning the model, I used this '
            'dataset to evaluate the quality of generated summaries by comparing them with human-written ones. ',
        technologies: """
Python,
FastAPI,
PyTorch,
Transformers (Hugging Face),
React,
Web Scraping (Python)
""",
        githubUrl: "https://github.com/Rosie1028/nn_api",
        liveUrl:
            "https://play.google.com/store/apps/details?id=com.example.ecommerce",
        imageUrls: [
          "images/summary1.jpeg",
          "images/summary2.jpeg",
        ],
        featured: true,
        createdAt: "2024-01-15T10:30:00Z",
      ),
      Project(
        id: 2,
        title: "Personal Finance Tracker",
        description:
            'Personal Finance Tracker is a full-stack financial planning and tracking application developed using '
            'Flutter and Python. Originally built to meet my own personal budgeting needs, it has since evolved into '
            'a scalable solution designed to help individuals and households manage their finances more effectively. '
            'The app supports budgeting, spending analysis, debt tracking, and financial reporting—all within a secure and '
            'user-friendly interface. ',
        technologies: """
Frontend: Flutter,
Backend: Python (FastAPI),
Database: PostgreSQL,
Authentication: JWT (JSON Web Tokens)""",
        githubUrl: "https://github.com/Rosie1028/FinanceTracker",
        liveUrl: "https://taskdashboard.rosangelaherrera.dev",
        imageUrls: [
          "images/budget1.jpeg",
          "images/budget2.jpeg",
        ],
        featured: true,
        createdAt: "2024-01-10T14:20:00Z",
      ),
      Project(
        id: 3,
        title: "Company AI Assistant Demo",
        description:
            'Company AI Assistant Demo is a lightweight chatbot application developed using Streamlit and Python. '
            'Originally built for a medical institution, it has been generalized for broader use as a company-facing assistant. '
            'The chatbot simulates an internal AI assistant capable of answering predefined questions about projects, team members, '
            'and publications. It serves as a modular, customizable proof-of-concept for building conversational interfaces in '
            'organizational settings.',
        technologies: """
Python,
Streamlit,
Custom CSS,
In-Memory Data Storage,
Modular Architecture""",
        githubUrl: "https://github.com/Rosie1028/Company_chatbot_demo",
        liveUrl: "https://weather.rosangelaherrera.dev",
        featured: false,
        createdAt: "2024-01-05T09:15:00Z",
      ),
      Project(
        id: 4,
        title: "Personal Workout Planner and Tracker",
        description:
            'Personal Workout Planner & Tracker is a full-stack fitness application designed to help users plan workouts, '
            'log exercises, and track progress over time. Built for personal use and currently under active development, '
            'the app aims to provide a simple, cross-platform solution for managing fitness routines and staying motivated.',
        technologies: """
 Flutter,
 Python (FastAPI),
 SQLite,
JWT (planned),
Cross-Platform Support""",
        githubUrl: "https://github.com/Rosie1028/Tracker_backend",
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

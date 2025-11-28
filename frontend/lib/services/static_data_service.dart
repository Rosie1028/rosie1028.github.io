import '../models/personal_info.dart';
import '../models/project.dart';

class StaticDataService {
  static PersonalInfo getPersonalInfo() {
    return PersonalInfo(
      name: "Rosangela Herrera",
      title:
          "Software Developer | Data Analyst | Educator",
      email: "rosangelahs@icloud.com",
      phone: "+1 (561) 574-4947",
      location: "Austin, TX",
      bio:
          'I’m a Software Engineer with a strong interest in how technology can support learning, wellbeing, and human development. '
          ' I focus on creating practical solutions that genuinely help people, using technology thoughtfully rather than excessively. '
          'My background spans software engineering, customer service, and education. I value clarity, structure, and '
          ' continuous improvement in everything I do. '
          'I’m naturally analytical and intellectually curious, drawn to exploring ideas across disciplines. '
          ' This broad perspective helps me approach problems with depth and creativity, always seeking connections '
          ' that lead to better, more inclusive solutions. '
          'Currently, I’m exploring the intersection of AI, psychology, and education, with the long-term goal of developing innovative, '
          'human-centered technologies that are both effective and responsible. ',
      linkedinUrl: "https://linkedin.com/in/rosangela-herrera",
      githubUrl: "https://github.com/rosangela-herrera",
      websiteUrl: "https://rosangelaherrera.dev",
      imagePath: "images/IMG_8959.jpg",
      resumeUrl: "https://rosangelaherrera.dev/assets/Rosangela_Herrera_CV.pdf",
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
Python: Core backend development and data processing.
FastAPI: Lightweight web framework for building the RESTful API.
PyTorch: Deep learning framework used to train and deploy the summarization model.
Transformers (Hugging Face): Implements the NASES-based summarization pipeline.
React: Frontend framework for building an intuitive user interface.
Web Scraping (Python): Used to collect and structure the Cuban news dataset for evaluation and potential fine-tuning.
""",
        githubUrl: "https://github.com/Rosie1028/nn_api",
        liveUrl:
            "https://play.google.com/store/apps/details?id=com.example.ecommerce",
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
Frontend: Flutter
Backend: Python (FastAPI)
Database: PostgreSQL
Authentication: JWT (JSON Web Tokens)""",
        githubUrl: "https://github.com/Rosie1028/FinanceTracker",
        liveUrl: "https://taskdashboard.rosangelaherrera.dev",
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
Python: Core backend logic and data handling.
Streamlit: Web framework for building the interactive chat interface.
Custom CSS: Used to style and customize the frontend appearance.
In-Memory Data Storage: Sample data stored in Python dictionaries for quick prototyping.
Modular Architecture: Backend logic separated into agents for easy customization.""",
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
Frontend: Flutter
Backend: Python (FastAPI)
Database: SQLite (initial setup; may migrate to PostgreSQL)
Authentication: JWT (planned)
Cross-Platform Support: Designed for mobile and web deployment""",
        githubUrl: " https://github.com/Rosie1028/Tracker_backend",
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

import '../models/personal_info.dart';
import '../models/project.dart';

class StaticDataService {
  static PersonalInfo getPersonalInfo() {
    return PersonalInfo(
      name: "Rosangela Herrera",
      title:
          "Software Developer | RBT | Educator",
      email: "rosangelahs@icloud.com",
      phone: "+1 (561) 574-4947",
      location: "Austin, TX",
      bio: """
          - I am a Software Engineer and Registered Behavior Technician with experience in development, management and education. 
          - I am driven by curiosity and a genuine interest in improving how people interact with technology. 
          - I care deeply about people and their well-being , and that shapes the way I approach problem-solving. 
          - I enjoy thinking through challenges, building practical solutions and learning along the way.
""",
      linkedinUrl:
          "https://www.linkedin.com/in/rosangela-herrera-suarez-a22759217",
      githubUrl: "https://github.com/Rosie1028",
      websiteUrl: "https://rosangelaherrera.dev",
      imagePath: "assets/images/Profile.png",
      resumeUrl:
          "https://drive.google.com/file/d/1-H3-LMAs0pghXVqNlVPzofbHYtLdNqH9/view?usp=drive_link",
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
        featured: true,
        createdAt: "2024-01-15T10:30:00Z",
      ),
      Project(
        id: 5,
        title: "GWF — Wellbeing, Growth & Freedom",
        description:
            'GWF is a full-stack web application for the Wellbeing, Growth & Freedom movement. '
            'It includes a landing page, founder story and mission, a product shop with cart and checkout flow, '
            'and a contact form—all backed by an ASP.NET Core REST API and an Angular frontend. '
            'The app is deployed on Render with separate frontend and API services.',
        technologies: """
Angular,
TypeScript,
SCSS,
ASP.NET Core,
C#,
REST API,
Render""",
        githubUrl: "https://github.com/Rosie1028/GWF",
        liveUrl: "https://gwf-web.onrender.com",
        featured: true,
        createdAt: "2026-07-30T12:00:00Z",
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
        featured: true,
        underDevelopment: true,
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
        featured: true,
        underDevelopment: true,
        createdAt: "2023-12-20T16:45:00Z",
      ),
    ];
  }

  static List<Project> getFeaturedProjects() {
    return getProjects().where((project) => project.featured).toList();
  }

  static List<Project> getExcelProjects() {
    return [
      Project(
        id: 101,
        title: "Behavior Data Analysis",
        description:
            """This project analyzes classroom behavior data for a 6‑year‑old student showing task refusal and task compliance over a two‑week period. The goal is to demonstrate Excel skills while interpreting behavior trends in a realistic educational scenario.

The dataset includes:

Frequency counts of task refusal (target behavior)

Frequency counts of task compliance (replacement behavior)

Daily notes describing contextual patterns

A simple intervention: visual schedule + reinforcement""",
        technologies:
            "Excel, Data Analysis, Charts, Formulas, Data Visualization",
        fileUrl: "assets/excel/Behavior Data Analysis.xlsx",
        featured: false,
        createdAt: "2024-01-01T00:00:00Z",
      ),
    ];
  }

  static List<Project> getAIMLNotebooks() {
    return [
      Project(
        id: 201,
        title: "Sentiment Analysis using LSTM",
        description:
            "A simple end‑to‑end sentiment analysis model built from scratch using a custom tokenizer, "
            " custom vocabulary, and a PyTorch LSTM network. The IMDB dataset is processed without torchtext, and the "
            " model predicts whether a movie review is positive or negative.",
        technologies:
            "Python,PyTorch, Hugging Face Datasets, Custom tokenizer, Custom vocabulary, Custom numericalization, Google Colab",
        githubUrl:
            "https://github.com/Rosie1028/Colab-Projects/blob/main/Sentiment%20Analysis%20using%20LSTM.ipynb",
        featured: false,
        createdAt: "2024-01-01T00:00:00Z",
      ),
    ];
  }
}

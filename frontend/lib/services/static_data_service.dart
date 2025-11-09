import '../models/personal_info.dart';
import '../models/project.dart';

class StaticDataService {
  static PersonalInfo getPersonalInfo() {
    return PersonalInfo(
      name: "Rosangela Herrera",
      title: "Full Stack Developer & Data Analyst",
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
        title: """National News Summarizer


The project is organized into two repositories:

- **Backend API**: nn_api
- **Frontend Interface**: nn_frontend


## Features

- **Automated Summarization**: Paste any news article and receive a concise summary powered by NLP.
- **RESTful API**: Built with FastAPI, offering interactive documentation via Swagger UI.
- **Interactive Frontend**: Clean and responsive React interface for easy access.
- **Custom Dataset**: Includes a manually curated dataset of Cuban news articles and summaries for evaluation.
- **Thesis-Driven Development**: Designed with academic rigor and real-world application in mind.""",
        description:
            """
**National News Summarizer** is a full-stack application developed as my **final thesis project** during my Bachelor's degree.
 The project explores the power of **Natural Language Processing (NLP)** to automatically generate concise summaries from long-form
  news articles. It integrates a custom pipeline based on the NASES architecture and provides a user-friendly interface for real-time 
  summarization.To support this system, I **scraped and compiled a dataset of Cuban news articles and their corresponding 
  summaries**, which I published on Kaggle: Cuban News Dataset. Although I did not complete fine-tuning the model, I used this
   dataset to **evaluate the quality of generated summaries** by comparing them with human-written ones.""",
        technologies: """## Tech Stack

- **Python**: Core backend development and data processing.
- **FastAPI**: Lightweight web framework for building the RESTful API.
- **PyTorch**: Deep learning framework used to train and deploy the summarization model.
- **Transformers (Hugging Face)**: Implements the NASES-based summarization pipeline.
- **React**: Frontend framework for building an intuitive user interface.
- **Web Scraping (Python)**: Used to collect and structure the Cuban news dataset for evaluation and potential fine-tuning.
""",
        githubUrl: "https://github.com/Rosie1028/nn_frontend, https://github.com/Rosie1028/nn_api, https://www.kaggle.com/datasets/rosangelahs/cuban-news-dataset",
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

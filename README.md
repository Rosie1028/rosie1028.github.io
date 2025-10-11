# Portfolio Project

A modern portfolio app built with Flutter displaying static personal information and projects.

## Project Structure

```
Portfolio-1/
├── frontend/          # Flutter application
├── README.md
└── start_frontend.sh  # Quick start script
```

## Features

- Personal information display
- Project showcase with technology tags
- Responsive design
- Modern dark theme UI
- Social media links integration
- Contact information with clickable actions

## Getting Started

### Quick Start
```bash
./start_frontend.sh
```

### Manual Setup
```bash
cd frontend
flutter pub get
flutter run
```

## Deployment to GitHub Pages

### Automatic Deployment (Recommended)
1. Push your code to a GitHub repository
2. Go to repository Settings → Pages
3. Enable GitHub Pages and select "GitHub Actions" as source
4. The workflow will automatically build and deploy your app

### Manual Deployment
```bash
./deploy.sh
```

Your site will be available at: `https://[your-username].github.io/Portfolio-1/`

## Customization

To customize your portfolio information, edit the data in:
`frontend/lib/services/static_data_service.dart`

Update the following:
- Personal information (name, title, bio, contact details)
- Project information (titles, descriptions, technologies, links)
- Social media URLs

## Tech Stack

- **Frontend**: Flutter, Dart
- **UI Components**: Google Fonts, Font Awesome Icons
- **Data**: Static data (no backend required)
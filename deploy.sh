#!/bin/bash

# Flutter Portfolio Deployment Script
echo "🚀 Building Flutter app for GitHub Pages..."

# Navigate to frontend directory
cd frontend

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Installing dependencies..."
flutter pub get

# Build for web with GitHub Pages base href
echo "🔨 Building web app..."
flutter build web --release --base-href "/Portfolio-1/"

echo "✅ Build complete!"
echo ""
echo "📁 Built files are in: frontend/build/web/"
echo "🌐 To deploy to GitHub Pages:"
echo "   1. Push your code to GitHub"
echo "   2. Enable GitHub Pages in repository settings"
echo "   3. The GitHub Action will automatically deploy"
echo ""
echo "🔗 Your site will be available at:"
echo "   https://[your-username].github.io/Portfolio-1/"

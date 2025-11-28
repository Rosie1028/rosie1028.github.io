#!/bin/bash

# Flutter Portfolio Deployment Script
echo "🚀 Building and deploying Flutter app to GitHub Pages..."

# Navigate to frontend directory
cd frontend

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Installing dependencies..."
flutter pub get

# Build for web with GitHub Pages base href (root URL)
echo "🔨 Building web app..."
flutter build web --release --base-href "/"

# Go back to root
cd ..

# Copy build files to root
echo "📋 Copying build files to root..."
cp -r frontend/build/web/* .

# Ensure .nojekyll exists
touch .nojekyll

# Update base href in index.html (ensure it's correct for root URL)
sed -i '' 's|<base href="[^"]*">|<base href="/">|' index.html

# Switch to main branch (rosie1028.github.io uses main branch)
echo "🌿 Switching to main branch..."
git checkout main

# Stage all files
echo "📝 Staging files..."
git add .

# Commit changes
echo "💾 Committing changes..."
git commit -m "Deploy portfolio - $(date +'%Y-%m-%d %H:%M:%S')"

# Push to GitHub
echo "🚀 Pushing to GitHub..."
git push origin main

echo ""
echo "✅ Deployment complete!"
echo "⏳ Wait 5-10 minutes for GitHub Pages to update"
echo "🌐 Your portfolio will be available at:"
echo "   https://rosie1028.github.io/"

#!/bin/bash

# Portfolio Frontend Startup Script
echo "🚀 Starting Portfolio App..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    echo "Visit: https://docs.flutter.dev/get-started/install"
    exit 1
fi

# Navigate to frontend directory
cd frontend

# Install Flutter dependencies
echo "📱 Installing Flutter dependencies..."
flutter pub get

# Start Flutter app
echo "🎨 Starting Flutter portfolio app..."
flutter run

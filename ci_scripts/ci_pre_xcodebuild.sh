#!/bin/sh

# Xcode Cloud Pre-Build Script
# This script runs before Xcode builds your project
# It installs CocoaPods dependencies

set -e

echo "🔧 Installing CocoaPods dependencies..."

# Check if CocoaPods is installed
if ! command -v pod &> /dev/null; then
    echo "📦 Installing CocoaPods..."
    gem install cocoapods --no-document
fi

# Install pods
echo "📦 Running pod install..."
cd "$CI_WORKSPACE"
pod install --repo-update

echo "✅ CocoaPods installation complete!"


# Lottie Animations Folder

This folder contains Lottie animation files (.json) used in the app.

## Required Files

### see_more_toggle.json
- **Used in**: Inner Learning Screen (See More/See Less button)
- **Animation**: Arrow toggling from down to up
- **Duration**: ~0.4-0.5 seconds
- **Status**: ⚠️ Not yet added

## How to Add Lottie Files

1. Download from [LottieFiles.com](https://lottiefiles.com/)
2. Search for "arrow toggle", "expand collapse", or "chevron toggle"
3. Download as JSON
4. Place in this folder
5. Reference in code: `assets/lottie/filename.json`

## Current Implementation

The app uses a fallback to Material Icons if Lottie files are missing, so the app will work even without these files. However, adding the Lottie animations will provide a better user experience with smooth, professional animations.

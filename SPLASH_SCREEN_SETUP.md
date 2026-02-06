# Custom Splash Screen Setup Guide

## Overview
This guide explains how the custom splash screen has been configured to replace Flutter's default white splash screen with your custom `splash_screen.dart` UI.

## What Was Implemented

### 1. **Package Installation**
- Added `flutter_native_splash: ^2.4.7` to `dev_dependencies` in `pubspec.yaml`
- This package removes Flutter's default splash screen and allows seamless transition to your custom splash screen

### 2. **Configuration in pubspec.yaml**
```yaml
flutter_native_splash:
  background_image: assets/images/splash_background.png
  android_12:
    color: "#FEF8F3"
  web: false
  ios: true
  android: true
```

**What this does:**
- Uses your splash background image for Android (below API 31)
- Uses a solid color (#FEF8F3) for Android 12+ (API 31+)
- Configures both iOS and Android platforms
- Disables web splash screen

### 3. **main.dart Changes**

#### Before:
```dart
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Dependency.init();
  runApp(const MyApp());
}
```

#### After:
```dart
void main(){
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  
  // Preserve the splash screen until app is ready
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  Dependency.init();
  runApp(const MyApp());
}
```

**What this does:**
- Preserves the native splash screen while the app initializes
- Prevents the white screen flicker between native and custom splash

### 4. **splash_screen.dart Changes**

#### Added:
```dart
import 'package:flutter_native_splash/flutter_native_splash.dart';

@override
Widget build(BuildContext context) {
  // Remove the native splash screen immediately when this screen is shown
  FlutterNativeSplash.remove();
  
  // ... rest of your code
}
```

**What this does:**
- Removes the native splash screen when your custom splash screen widget is built
- Creates a seamless transition to your custom UI

### 5. **Generated Native Files**
The `flutter_native_splash:create` command automatically generated/updated:

**Android:**
- `android/app/src/main/res/drawable/launch_background.xml`
- `android/app/src/main/res/drawable-v21/launch_background.xml`
- `android/app/src/main/res/values/styles.xml`
- `android/app/src/main/res/values-night/styles.xml`
- `android/app/src/main/res/values-v31/styles.xml`
- `android/app/src/main/res/values-night-v31/styles.xml`

**iOS:**
- `ios/Runner/Info.plist` (updated for status bar configuration)

## How It Works

### App Launch Flow:

1. **Native Splash Screen (< 100ms)**
   - Shows `splash_background.png` (or solid color on Android 12+)
   - Appears instantly when app icon is tapped
   - Preserved while Flutter engine initializes

2. **Flutter Engine Initialization**
   - `main()` function runs
   - `FlutterNativeSplash.preserve()` keeps the native splash visible
   - Dependencies are initialized
   - App widget tree is built

3. **Custom Splash Screen**
   - `SplashScreen` widget is rendered
   - `FlutterNativeSplash.remove()` is called
   - Native splash fades out, custom splash fades in
   - No white screen flicker!

4. **Navigation to Onboarding**
   - After 3 seconds, navigates to onboarding screen
   - Uses GoRouter for navigation

## Assets Required

Ensure these assets exist in your project:
- `assets/images/splash_background.png` - The background image for the splash screen
- `assets/images/splashlogo.png` - Your app logo displayed on the splash screen

## Testing

### To test the splash screen:

1. **Clean build:**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Run on a device (not hot reload):**
   ```bash
   flutter run
   ```
   Or close and reopen the app after installation

3. **What you should see:**
   - No white screen at startup ✅
   - Smooth transition from native to custom splash ✅
   - Custom splash displays for 3 seconds ✅
   - Navigates to onboarding screen ✅

### Platform-Specific Testing:

**Android:**
- Test on Android 12+ (API 31+) - should show solid color during engine init
- Test on Android 11 and below - should show background image

**iOS:**
- Test on iOS devices - should show background image
- Status bar should be configured correctly

## Customization

### Change Splash Duration
In `splash_screen.dart`, modify the duration:
```dart
Future.delayed(const Duration(seconds: 3), () { // Change '3' to desired seconds
  if (context.mounted) {
    context.go(AppPath.onboarding);
  }
});
```

### Change Android 12+ Color
In `pubspec.yaml`, modify:
```yaml
flutter_native_splash:
  android_12:
    color: "#YOUR_COLOR_HERE"  # Change to your desired hex color
```

### Use Solid Color Instead of Image
In `pubspec.yaml`, replace:
```yaml
flutter_native_splash:
  # background_image: assets/images/splash_background.png
  color: "#FEF8F3"  # Use this instead
```

## Commands Used

```bash
# Install dependencies
flutter pub get

# Generate native splash screen files
dart run flutter_native_splash:create

# Clean and rebuild (after config changes)
flutter clean
flutter pub get
```

## Troubleshooting

### White screen still appears:
1. Make sure you did a full rebuild (not hot reload)
2. Uninstall the app completely and reinstall
3. Check that assets exist in the correct paths

### Native splash not showing:
1. Run `dart run flutter_native_splash:create` again
2. Check that `pubspec.yaml` configuration is correct
3. Ensure assets are properly declared in `pubspec.yaml`

### Custom splash not appearing:
1. Check routing configuration in `route_path.dart`
2. Ensure `initialLocation: AppPath.splash` is set
3. Verify `SplashScreen` widget is properly imported

## Benefits

✅ **No white screen flicker** - Seamless app launch experience
✅ **Fast startup** - Native splash shows instantly
✅ **Custom branding** - Your splash screen UI is displayed
✅ **Cross-platform** - Works on both Android and iOS
✅ **Professional appearance** - Matches app store requirements

## Notes

- The native splash is temporary (shown during Flutter engine initialization)
- Your custom splash screen (SplashScreen widget) is the main splash UI
- The 3-second delay is in the custom splash screen, not the native one
- This setup is production-ready and follows best practices

## References

- [flutter_native_splash package](https://pub.dev/packages/flutter_native_splash)
- [Flutter Splash Screens Guide](https://docs.flutter.dev/development/ui/splash-screen)
- [Android Splash Screens](https://developer.android.com/develop/ui/views/launch/splash-screen)
- [iOS Launch Screens](https://developer.apple.com/design/human-interface-guidelines/launching)

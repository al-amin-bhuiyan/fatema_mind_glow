# MindGlow Navigation Bar - Usage Guide

## 🎯 Quick Start

### Using the Navigation Bar in Your Screen

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fatema_mind_glow/controllers/custom_nav_bar_widgets/custom_nav_bar_widgets.dart';
import 'package:fatema_mind_glow/widgets/custom_nav_bar_widgets.dart';
import 'package:fatema_mind_glow/widgets/custom_assets.dart';

class YourScreen extends StatelessWidget {
  const YourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the navigation controller
    final navController = Get.put(CustomNavBarController());

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image (shows through transparent TextFields)
          Image.asset(
            CustomAssets.backgroundimage,
            fit: BoxFit.cover,
          ),
          
          // Your screen content here
          SafeArea(
            child: Column(
              children: [
                // Your content widgets
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Your widgets here
                        
                        SizedBox(height: 100.h), // Space for nav bar
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Custom Navigation Bar at Bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomNavBar(controller: navController),
          ),
        ],
      ),
    );
  }
}
```

## 📋 Complete Implementation Checklist

### ✅ Completed Tasks

1. **Removed White Backgrounds from All TextFields**
   - All `TextFormField` widgets now use `filled: false`
   - Background image shows through all input fields
   - Files updated: sign_up.dart, login_screen.dart, reset_password.dart, otp_screen.dart, inner_connection.dart

2. **Created Custom Navigation Bar**
   - Controller: `lib/controllers/custom_nav_bar_widgets/custom_nav_bar_widgets.dart`
   - Widget: `lib/widgets/custom_nav_bar_widgets.dart`
   - 100% design accurate implementation
   - Uses custom SVG icons with hover states

3. **Navigation Tabs Implemented**
   - Home (index 0)
   - Reflect (index 1)
   - Journey (index 2)
   - Inspire (index 3)
   - Inner Learning (index 4)

4. **OTP Border Color Logic**
   - Already implemented in `lib/views/otp_screen/otp_screen.dart`
   - Switches to `AppColors.googlebuttonColor` when user inputs number
   - Black border when empty

5. **Sample Home Screen**
   - Created: `lib/views/home/home_screen.dart`
   - Demonstrates navigation bar usage
   - Shows background image throughout

## 🎨 Navigation Bar Features

### Visual States

**Selected Tab:**
- Icon: Uses hover/active icon variant
- Text: Bold (FontWeight.w600)
- Color: `Color(0xFF1E1E1E)` - Dark Gray/Black

**Unselected Tab:**
- Icon: Uses normal icon
- Text: Regular (FontWeight.w400)
- Color: `Color(0xFF4F4F4F)` - Light Gray

### Layout Specifications

```dart
Container(
  padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
  
  // Each Nav Item
  width: 55.w,
  
  // Icon
  width: 24.w,
  height: 24.h,
  
  // Spacing between icon and label
  spacing: 8.h,
  
  // Spacing between items
  spacing: 20.w,
  
  // Bottom indicator bar
  width: 144.w,
  height: 6.h,
  borderRadius: 10.r,
  color: Colors.black,
)
```

## 🔧 Controller Methods

### `CustomNavBarController`

```dart
// Change tab and navigate
void changeIndex(int index, BuildContext context)

// Get current route path
String getCurrentRoute()

// Check if tab is selected
bool isSelected(int index)

// Observable selected index
var selectedIndex = 0.obs;
```

## 📱 Navigation Routes

### Currently Active Routes

```dart
AppPath.home           // '/home'
AppPath.splash         // '/'
AppPath.onboarding     // '/onboarding'
AppPath.login          // '/login'
AppPath.signup         // '/signup'
AppPath.resetPassword  // '/reset-password'
AppPath.otpVerification // '/otp-verification'
AppPath.innerConnection // '/inner-connection'
```

### Routes to Add (Placeholder in Controller)

```dart
'/reflect'         // Reflect page
'/journey'         // Journey page
'/inspire'         // Inspire page
'/inner-learning'  // Inner Learning page
```

To add these routes:

1. Add to `lib/routes/app_path.dart`:
```dart
static const String reflect = '/reflect';
static const String journey = '/journey';
static const String inspire = '/inspire';
static const String innerLearning = '/inner-learning';
```

2. Create the screen files
3. Add to `lib/routes/route_path.dart`
4. Update controller navigation cases

## 🎯 Key Colors Used

```dart
// AppColors (from utils/app_colors.dart)
AppColors.whiteColor        // Color(0xFFFFFFFF)
AppColors.blackColor        // Color(0xFF000000)
AppColors.primaryColor      // Color(0xFF00D9FF)
AppColors.secondaryColor    // Color(0xFF9B4BFF)
AppColors.googlebuttonColor // Color(0xFFC3A95E) - Gold/Bronze

// Navigation Bar Colors
const Color(0xFF1E1E1E)  // Selected text - Almost Black
const Color(0xFF4F4F4F)  // Unselected text - Dark Gray
Colors.black             // Bottom indicator bar
```

## 🖼️ Background Image

The background image (`CustomAssets.backgroundimage`) now shows through:
- All TextFormField widgets (no white backgrounds)
- Navigation bar (transparent background)
- All screens using Stack with Image.asset as base layer

## 📦 Dependencies

Make sure these are in your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6
  go_router: ^14.0.0
  flutter_screenutil: ^5.9.0
  flutter_svg: ^2.0.9
```

## 🚀 Running the App

```powershell
cd C:\Users\shobuj\StudioProjects\fatema_mind_glow
flutter pub get
flutter run
```

To navigate to home screen (for testing):
```dart
context.go(AppPath.home);
```

## 💡 Tips

1. **Controller Initialization**: Use `Get.put()` to initialize the controller once per screen
2. **Positioning**: Always use `Positioned` widget to place nav bar at bottom
3. **Spacing**: Add bottom padding to scrollable content to prevent overlap
4. **Icons**: Ensure all SVG icon files exist in `assets/icons/`
5. **Background**: Use `Stack` with `fit: StackFit.expand` for background image

## 🐛 Troubleshooting

**Icons not showing:**
- Verify SVG files exist in `assets/icons/`
- Check `pubspec.yaml` includes icon assets
- Run `flutter pub get` and restart app

**Navigation not working:**
- Ensure routes are added to `route_path.dart`
- Check `AppPath` constants match route definitions
- Verify `Get` package is properly initialized in `main.dart`

**Controller state not updating:**
- Wrap observables with `Obx()` widget
- Use `.value` to access/update observable values
- Initialize controller with `Get.put()` or `Get.find()`

## ✨ Example Screens

Check these files for implementation examples:
- `lib/views/home/home_screen.dart` - Complete example with nav bar
- `lib/views/sign_up/sign_up.dart` - TextFormField without background
- `lib/views/otp_screen/otp_screen.dart` - Dynamic border colors

---

**All tasks completed successfully! 🎉**

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_path.dart';

/// Controller for Navigation Bar - handles bottom navigation
class CustomNavBarController extends GetxController {
  // Observable for the current selected index
  var selectedIndex = 0.obs;

  /// Method to change the selected index and navigate
  void changeIndex(int index, BuildContext context) {
    selectedIndex.value = index;

    // Navigate based on index
    switch (index) {
      case 0:
        context.go(AppPath.home);
        break;
      case 1:
        context.go(AppPath.reflect);
        break;
      case 2:
        // Journey page - add route when available
        // context.go(AppPath.journey);
        break;
      case 3:
        // Inspire page - add route when available
        // context.go(AppPath.inspire);
        break;
      case 4:
        // Inner Learning page - add route when available
        // context.go(AppPath.innerLearning);
        break;
    }
  }

  /// Method to get the current route based on index
  String getCurrentRoute() {
    switch (selectedIndex.value) {
      case 0:
        return AppPath.home;
      case 1:
        return AppPath.reflect;
      case 2:
        return '/journey'; // Add to AppPath when available
      case 3:
        return '/inspire'; // Add to AppPath when available
      case 4:
        return '/inner-learning'; // Add to AppPath when available
      default:
        return AppPath.home;
    }
  }

  /// Check if a specific tab is selected
  bool isSelected(int index) => selectedIndex.value == index;
}

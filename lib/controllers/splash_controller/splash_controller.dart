import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_path.dart';

class SplashController extends GetxController {
  final RxBool _isNavigating = false.obs;
  
  bool get isNavigating => _isNavigating.value;

  @override
  void onInit() {
    super.onInit();
    // Initialize any app-wide settings here if needed
    _navigateToOnboarding();
  }

  Future<void> _navigateToOnboarding() async {
    if (_isNavigating.value) return;
    
    _isNavigating.value = true;
    
    // Minimal delay to show splash (200ms for smooth transition)
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Navigate to onboarding screen
    if (Get.context != null) {
      Get.context!.go(AppPath.onboarding);
    }
  }
}

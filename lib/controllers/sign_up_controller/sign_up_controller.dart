import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_path.dart';

/// SignUp Controller - Manages sign up screen state and logic
class SignUpController extends GetxController {
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text editing controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Observable states
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isEmailValid = false.obs;
  final RxBool isFullNameValid = false.obs;

  // Email validation regex
  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void onInit() {
    super.onInit();
    // Listen to field changes for real-time validation
    emailController.addListener(_validateEmail);
    fullNameController.addListener(_validateFullName);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  /// Validate email in real-time
  void _validateEmail() {
    isEmailValid.value = _emailRegex.hasMatch(emailController.text);
  }

  /// Validate full name in real-time
  void _validateFullName() {
    isFullNameValid.value = fullNameController.text.trim().length >= 2;
  }

  /// Validate form
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  /// Full name validator
  String? fullNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.trim().length < 2) {
      return 'Full name must be at least 2 characters';
    }
    return null;
  }

  /// Email validator
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  /// Password validator
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Confirm password validator
  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Sign up with email and password
  Future<void> signUpWithEmail(BuildContext context) async {
    if (!validateForm()) return;

    try {
      isLoading.value = true;
      
      // TODO: Implement actual sign-up logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulating API call
      
      // Navigate to inner connection page after successful signup
      if (context.mounted) {
        context.push(AppPath.innerConnection);
      }
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Sign up failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Sign up with Google
  Future<void> signUpWithGoogle() async {
    try {
      isLoading.value = true;
      
      // TODO: Implement Google Sign-up logic
      await Future.delayed(const Duration(seconds: 2));
      
      Get.snackbar(
        'Success',
        'Google sign-up successful!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Google sign-up failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Sign up with Apple
  Future<void> signUpWithApple() async {
    try {
      isLoading.value = true;
      
      // TODO: Implement Apple Sign-up logic
      await Future.delayed(const Duration(seconds: 2));
      
      Get.snackbar(
        'Success',
        'Apple sign-up successful!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Apple sign-up failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Navigate to Sign In screen
  void navigateToSignIn(BuildContext context) {
  context.pop();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// OTP Screen Controller - Manages OTP verification screen state and logic
class OtpScreenController extends GetxController {
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text editing controllers for each OTP digit
  final TextEditingController otp1Controller = TextEditingController();
  final TextEditingController otp2Controller = TextEditingController();
  final TextEditingController otp3Controller = TextEditingController();
  final TextEditingController otp4Controller = TextEditingController();
  final TextEditingController otp5Controller = TextEditingController();
  final TextEditingController otp6Controller = TextEditingController();

  // Focus nodes for each OTP field
  final FocusNode otp1FocusNode = FocusNode();
  final FocusNode otp2FocusNode = FocusNode();
  final FocusNode otp3FocusNode = FocusNode();
  final FocusNode otp4FocusNode = FocusNode();
  final FocusNode otp5FocusNode = FocusNode();
  final FocusNode otp6FocusNode = FocusNode();

  // Observable states
  final RxBool isLoading = false.obs;
  final RxString userEmail = ''.obs;
  
  // Observable states for each OTP field to track input
  final RxString otp1 = ''.obs;
  final RxString otp2 = ''.obs;
  final RxString otp3 = ''.obs;
  final RxString otp4 = ''.obs;
  final RxString otp5 = ''.obs;
  final RxString otp6 = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to controller changes to update observable states
    otp1Controller.addListener(() => otp1.value = otp1Controller.text);
    otp2Controller.addListener(() => otp2.value = otp2Controller.text);
    otp3Controller.addListener(() => otp3.value = otp3Controller.text);
    otp4Controller.addListener(() => otp4.value = otp4Controller.text);
    otp5Controller.addListener(() => otp5.value = otp5Controller.text);
    otp6Controller.addListener(() => otp6.value = otp6Controller.text);
  }

  /// Set email from route parameters
  void setEmail(String email) {
    userEmail.value = email;
  }

  @override
  void onClose() {
    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();
    otp5Controller.dispose();
    otp6Controller.dispose();
    
    otp1FocusNode.dispose();
    otp2FocusNode.dispose();
    otp3FocusNode.dispose();
    otp4FocusNode.dispose();
    otp5FocusNode.dispose();
    otp6FocusNode.dispose();
    
    super.onClose();
  }

  /// Get the complete OTP code
  String getOtpCode() {
    return otp1Controller.text +
        otp2Controller.text +
        otp3Controller.text +
        otp4Controller.text +
        otp5Controller.text +
        otp6Controller.text;
  }

  /// Verify OTP code
  Future<void> verifyCode() async {
    final otpCode = getOtpCode();
    
    if (otpCode.length != 6) {
      Get.snackbar(
        'Error',
        'Please enter the complete 6-digit code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // TODO: Implement your OTP verification logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulating API call

      Get.snackbar(
        'Success',
        'OTP verified successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate to next screen (e.g., new password screen or home)
      // context.go(AppPath.home);

    } catch (e) {
      Get.snackbar(
        'Error',
        'Invalid OTP code. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Resend OTP code
  Future<void> resendCode(BuildContext context) async {
    try {
      isLoading.value = true;

      // TODO: Implement your resend OTP logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulating API call

      Get.snackbar(
        'Success',
        'OTP code has been resent to ${userEmail.value}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Clear all OTP fields
      clearOtpFields();

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend OTP code. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear all OTP fields
  void clearOtpFields() {
    otp1Controller.clear();
    otp2Controller.clear();
    otp3Controller.clear();
    otp4Controller.clear();
    otp5Controller.clear();
    otp6Controller.clear();
    otp1FocusNode.requestFocus();
  }

  /// Handle OTP input and auto-focus next field
  void onOtpChanged(String value, int index, BuildContext context) {
    if (value.length == 1 && index < 6) {
      // Move to next field
      switch (index) {
        case 1:
          otp2FocusNode.requestFocus();
          break;
        case 2:
          otp3FocusNode.requestFocus();
          break;
        case 3:
          otp4FocusNode.requestFocus();
          break;
        case 4:
          otp5FocusNode.requestFocus();
          break;
        case 5:
          otp6FocusNode.requestFocus();
          break;
        case 6:
          otp6FocusNode.unfocus();
          break;
      }
    } else if (value.isEmpty && index > 1) {
      // Move to previous field on backspace
      switch (index) {
        case 2:
          otp1FocusNode.requestFocus();
          break;
        case 3:
          otp2FocusNode.requestFocus();
          break;
        case 4:
          otp3FocusNode.requestFocus();
          break;
        case 5:
          otp4FocusNode.requestFocus();
          break;
        case 6:
          otp5FocusNode.requestFocus();
          break;
      }
    }
  }

  /// Navigate back to reset password screen
  void navigateBack(BuildContext context) {
    context.pop();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/splash_controller/splash_controller.dart';
import '../../routes/app_path.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/custom_assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the SplashController instance
    final controller = Get.find<SplashController>();
    
    // Schedule navigation after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (context.mounted) {
          context.go(AppPath.onboarding);
        }
      });
    });

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            CustomAssets.splashbackgorund,
            fit: BoxFit.cover,
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Logo (PNG) - use Image.asset for PNG files
                Image.asset(
                  CustomAssets.splashlogo,
                  width: 350.w,
                  height: 98.h,
                ),
                SizedBox(height: 24.h),

                Text(
                 "This is a quite, private space \n-just fot you.\n No pressure. No judgement.\n Nothing to prove.",
                  textAlign: TextAlign.center,
                  style: AppFonts.poppinsRegular(
                    fontSize: 18.sp,
                    color: const Color(0xFF666666),
                    height: 1.5,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}


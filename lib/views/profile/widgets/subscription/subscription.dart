import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../widgets/custom_assets.dart';
import 'subscription_controller.dart';

/// Subscription Screen - Displays subscription plans
class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CustomAssets.backgroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              _buildAppBar(context, controller),
              
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        
                        // Free Plan Card
                        _buildFreePlanCard(),
                        
                        SizedBox(height: 16.h),
                        
                        // Inner Plan Card
                        _buildInnerPlanCard(controller, context),
                        
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build App Bar
  Widget _buildAppBar(BuildContext context, SubscriptionController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),
      decoration: BoxDecoration(color: const Color(0xFFFEF8F3)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.goBack(context),
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: ShapeDecoration(
                color: Colors.black.withValues(alpha: 0.10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
              child: Icon(
                Icons.arrow_back,
                size: 18.sp,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Subscription',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 30.w),
        ],
      ),
    );
  }

  /// Build Free Plan Card
  Widget _buildFreePlanCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(CustomAssets.mindglow_free_background),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 318.w,
                  child: Text(
                    'MindGlow - Free',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF111928),
                      fontSize: 24.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  '\$0',
                  style: TextStyle(
                    color: const Color(0xFF111928),
                    fontSize: 32.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 16.h),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFeatureItem('Gentle reflective prompts'),
                      SizedBox(height: 16.h),
                      _buildFeatureItem('A quiet space to pause and reflect'),
                      SizedBox(height: 16.h),
                      _buildFeatureItem('Limited reflections per  week'),
                      SizedBox(height: 16.h),
                      _buildFeatureItem('Your recent reflections saved'),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Reflection should always remain accessible',
                  style: TextStyle(
                    color: const Color(0xFF111928),
                    fontSize: 15.sp,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    height: 1.60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build Inner Plan Card
  Widget _buildInnerPlanCard(
    SubscriptionController controller,
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(CustomAssets.mindglow_inner_background),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'MindGlow - Inner 🍃 ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1E1E1E),
                    fontSize: 24.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '\$8.99',
                            style: TextStyle(
                              color: const Color(0xFF1E1E1E),
                              fontSize: 18.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: '/month',
                            style: TextStyle(
                              color: const Color(0xFF1E1E1E),
                              fontSize: 12.sp,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'or',
                      style: TextStyle(
                        color: const Color(0xCC1E1E1E),
                        fontSize: 14.sp,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '\$69',
                            style: TextStyle(
                              color: const Color(0xFF1E1E1E),
                              fontSize: 18.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: '/year',
                            style: TextStyle(
                              color: const Color(0xFF1E1E1E),
                              fontSize: 12.sp,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '(gental continuty)',
                      style: TextStyle(
                        color: const Color(0xCC1E1E1E),
                        fontSize: 14.sp,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom: 16.h),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.white),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInnerFeatureItem('Unlimited reflections'),
                            SizedBox(height: 16.h),
                            _buildInnerFeatureItem('Full reflection history'),
                            SizedBox(height: 16.h),
                            _buildInnerFeatureItem(
                              'Inner Learning - optional materials to explore ',
                            ),
                            SizedBox(height: 16.h),
                            _buildInnerFeatureItem(
                              'Reflective Dialogue (Advanced) deeper reflective respone, without direction',
                            ),
                            SizedBox(height: 16.h),
                            _buildInnerFeatureItem(
                              'Early access to new reflective experience',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Nothing is assigned. Nothing is required.',
                        style: TextStyle(
                          color: const Color(0xFF111928),
                          fontSize: 15.sp,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                          height: 1.60,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () => controller.continueWithPlan(context),
                  child: Container(
                    width: double.infinity,
                    height: 54.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          CustomAssets.continue_with_mindglow_inner_button_background,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Center(
                      child: Text(
                        'Continue with GlowMind Inner',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build Feature Item for Free Plan
  Widget _buildFeatureItem(String text) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 16.w,
            height: 16.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: SvgPicture.asset(
              CustomAssets.subscription_right_sign,
              width: 16.w,
              height: 16.h,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: const Color(0xFF111928),
                fontSize: 16.sp,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                height: 1.50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build Inner Feature Item
  Widget _buildInnerFeatureItem(String text) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 16.w,
            height: 16.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: SvgPicture.asset(
              CustomAssets.subscription_right_sign,
              width: 16.w,
              height: 16.h,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: const Color(0xFF1E1E1E),
                fontSize: 16.sp,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                height: 1.50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

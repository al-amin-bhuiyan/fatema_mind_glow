import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../widgets/custom_assets.dart';
import 'terms_and_condition_controller.dart';
import 'widgets/terms_section_widget.dart';

/// Terms & Conditions Screen - Displays the app's terms and conditions
class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TermsConditionController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
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
              _buildAppBar(controller, context),

              // Terms Content
              Expanded(
                child: Obx(() {
                  if (controller.sections.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: const Color(0xFFC39D4C),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),

                        // Render all sections
                        ...controller.sections.map((section) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 24.h),
                            child: TermsSectionWidget(section: section),
                          );
                        }),

                        // Contact Email (after section 10)
                        _buildContactEmail(controller),

                        SizedBox(height: 32.h),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build App Bar
  Widget _buildAppBar(
      TermsConditionController controller, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.goBack(context),
            child: Container(
              width: 30.w,
              height: 30.h,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.black.withValues(alpha: 0.10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
              child: Icon(
                Icons.arrow_back,
                size: 24.sp,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Terms & Condition',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 1.11,
              ),
            ),
          ),
          SizedBox(width: 30.w),
        ],
      ),
    );
  }

  /// Build Contact Email
  Widget _buildContactEmail(TermsConditionController controller) {
    return Text(
      controller.contactEmail,
      style: TextStyle(
        color: const Color(0xFF1E1E1E),
        fontSize: 16.sp,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
    );
  }
}

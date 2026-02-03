import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../widgets/custom_assets.dart';
import 'faqs_controller.dart';
import 'widgets/faq_item_widget.dart';

/// FAQs Screen - Displays frequently asked questions with expandable answers
class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FaqsController());

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

              // FAQs List
              Expanded(
                child: Obx(() {
                  if (controller.faqList.isEmpty) {
                    return Center(
                      child: Text(
                        'No FAQs available',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 26.w,
                      vertical: 16.h,
                    ),
                    itemCount: controller.faqList.length,
                    separatorBuilder: (context, index) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final faq = controller.faqList[index];
                      return FaqItemWidget(
                        question: faq.question,
                        answer: faq.answer,
                        isExpanded: faq.isExpanded,
                        onTap: () => controller.toggleExpansion(index),
                      );
                    },
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
  Widget _buildAppBar(FaqsController controller, BuildContext context) {
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
                size: 18.sp,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'FAQs',
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
}

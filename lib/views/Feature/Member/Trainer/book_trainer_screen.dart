import 'package:fitness/controllers/member/book_trainer_controller.dart';
import 'package:fitness/utils/AppColor/app_colors.dart';
import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:fitness/views/Base/CustomAppbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'steps/booking_personal_info.dart';
import 'steps/booking_date_time.dart';
import 'steps/booking_payment.dart';

class BookTrainerScreen extends StatelessWidget {
  const BookTrainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookTrainerController controller = Get.put(BookTrainerController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(1.0, -1.0),
                radius: 2.5,
                colors: [
                  const Color(0xFFFFA6B4).withValues(alpha: 0.5),
                  const Color(0xFFFFE0B9).withValues(alpha: 0.25),
                  Colors.white,
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const CustomAppbar(title: "Book Trainer"),
                ),
                SizedBox(height: 24.h),
                _buildProgressIndicator(controller),
                SizedBox(height: 32.h),
                Expanded(
                  child: Obx(() {
                    return IndexedStack(
                      index: controller.currentStep.value - 1,
                      children: [
                        BookingPersonalInfo(controller: controller),
                        BookingDateTime(controller: controller),
                        BookingPayment(controller: controller),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
          _buildBottomButton(controller),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(BookTrainerController controller) {
    return Obx(() {
      int step = controller.currentStep.value;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            _buildStepCircle(true, step >= 1),
            _buildStepLine(step >= 2),
            _buildStepCircle(step >= 2, step >= 2),
            _buildStepLine(step >= 3),
            _buildStepCircle(step >= 3, step >= 3),
          ],
        ),
      );
    });
  }

  Widget _buildStepCircle(bool isActive, bool isCompleted) {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.actionPrimary.withValues(alpha: 0.1) : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? AppColors.actionPrimary : AppColors.borderPrimary,
          width: 2,
        ),
      ),
      child: Center(
        child: Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: isActive ? AppColors.actionPrimary : Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildStepLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? AppColors.actionPrimary : AppColors.borderPrimary,
      ),
    );
  }

  Widget _buildBottomButton(BookTrainerController controller) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Obx(() {
          bool isLastStep = controller.currentStep.value == 3;
          if (isLastStep) {
            return Container(
              width: double.infinity,
              height: 64.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("\$85.52", style: AppTextStyles.base16Bold.copyWith(color: Colors.white)),
                      Text("Total Price", style: AppTextStyles.sm14Regular.copyWith(color: Colors.white.withValues(alpha: 0.7), fontSize: 10.sp)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => controller.nextStep(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: AppColors.actionPrimary,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Text("Checkout", style: AppTextStyles.sm14Medium.copyWith(color: Colors.white)),
                          SizedBox(width: 8.w),
                          Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 18.sp),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return GestureDetector(
            onTap: () => controller.nextStep(),
            child: Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Continue",
                    style: AppTextStyles.base16Medium.copyWith(color: Colors.white),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 20.sp),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

import 'package:fitness/controllers/member/book_trainer_controller.dart';
import 'package:fitness/utils/AppColor/app_colors.dart';
import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:fitness/views/Base/CustomAppbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'steps/booking_card_payment.dart';
import 'steps/booking_date_time.dart';
import 'steps/booking_payment.dart';
import 'steps/booking_personal_info.dart';
import 'steps/booking_session_select.dart';

class BookTrainerScreen extends StatelessWidget {
  const BookTrainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<BookTrainerController>()
        ? Get.find<BookTrainerController>()
        : Get.put(BookTrainerController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(1.0, -1.0),
                radius: 2.5,
                colors: [
                  const Color(0xFFFFA6B4).withValues(alpha: 0.24),
                  const Color(0xFFFFE0B9).withValues(alpha: 0.12),
                  Colors.white,
                ],
                stops: const [0.0, 0.72, 1.0],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 14.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomAppbar(
                    title: 'Book Trainer',
                    onTap: controller.previousStep,
                  ),
                ),
                SizedBox(height: 20.h),
                _ProgressIndicator(controller: controller),
                SizedBox(height: 22.h),
                Expanded(
                  child: Obx(
                    () => IndexedStack(
                      index: controller.currentStep.value - 1,
                      children: [
                        BookingPersonalInfo(controller: controller),
                        BookingDateTime(controller: controller),
                        BookingSessionSelect(controller: controller),
                        BookingPayment(
                          controller: controller,
                          onSelectPaymentMethod: () =>
                              _showPaymentMethodSheet(controller),
                        ),
                        BookingCardPayment(
                          controller: controller,
                          onCheckout: () => _showPaymentResultDialog(
                            success: true,
                            controller: controller,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _BottomButton(controller: controller),
        ],
      ),
    );
  }

  void _showPaymentMethodSheet(BookTrainerController controller) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 56.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.borderPrimary,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                'Select Payment Methods',
                style: AppTextStyles.xs12SemiBold.copyWith(
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              SizedBox(height: 20.h),
              _PaymentMethodTile(
                title: 'Strip',
                trailing: 'stripe',
                onTap: () => controller.setPaymentMethod('Stripe'),
              ),
              _PaymentMethodTile(
                title: 'Apple Pay',
                trailing: 'Pay',
                icon: Icons.apple_rounded,
                onTap: () => controller.setPaymentMethod('Apple Pay'),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 52.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.borderPrimary),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add, size: 18.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Add debit/credit card',
                          style: AppTextStyles.xs12Medium.copyWith(
                            color: AppColors.textPrimary,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded, size: 20.sp),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Select  ✓',
                    style: AppTextStyles.xs12SemiBold.copyWith(
                      color: Colors.white,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showPaymentResultDialog({
    required bool success,
    required BookTrainerController controller,
  }) {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 34.w),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(18.w, 20.h, 18.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: success
                      ? AppColors.statusSuccessSubtle
                      : AppColors.statusErrorSubtle,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  success
                      ? Icons.shopping_cart_checkout_rounded
                      : Icons.shopping_cart_outlined,
                  color: success
                      ? AppColors.statusSuccess
                      : AppColors.statusError,
                  size: 22.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                success ? 'Payment Completed!' : 'Payment Unsuccessful',
                textAlign: TextAlign.center,
                style: AppTextStyles.sm14SemiBold.copyWith(
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                success
                    ? 'You have successfully completed fitness coach booking. We sent receipt to your email. Thank you!'
                    : 'Your card was declined. Please check your details or try a different payment method.',
                textAlign: TextAlign.center,
                style: AppTextStyles.xs12Regular.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.35,
                  letterSpacing: 0,
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Get.back();
                  if (success) Get.back();
                },
                child: Container(
                  height: 46.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    success ? 'Done  ✓' : 'Try again',
                    style: AppTextStyles.xs12SemiBold.copyWith(
                      color: Colors.white,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
              if (!success) ...[
                SizedBox(height: 10.h),
                Text(
                  'Change payment method',
                  style: AppTextStyles.xs12Medium.copyWith(
                    color: AppColors.textPrimary,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final BookTrainerController controller;

  const _ProgressIndicator({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final visualStep = controller.currentStep.value <= 1
          ? 1
          : controller.currentStep.value <= 3
          ? 2
          : 3;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Row(
          children: [
            _circle(active: true),
            _line(active: visualStep >= 2),
            _circle(active: visualStep >= 2),
            _line(active: visualStep >= 3),
            _circle(active: visualStep >= 3),
          ],
        ),
      );
    });
  }

  Widget _circle({required bool active}) {
    return Container(
      width: 16.w,
      height: 16.w,
      decoration: BoxDecoration(
        color: active ? AppColors.actionPrimary : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: active ? AppColors.actionPrimary : AppColors.borderPrimary,
          width: 1.2.w,
        ),
      ),
      child: Center(
        child: Container(
          width: 5.w,
          height: 5.w,
          decoration: BoxDecoration(
            color: active ? Colors.white : AppColors.borderPrimary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _line({required bool active}) {
    return Expanded(
      child: Container(
        height: 1.h,
        color: active ? AppColors.actionPrimary : AppColors.borderPrimary,
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  final BookTrainerController controller;

  const _BottomButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.currentStep.value >= 5) return const SizedBox.shrink();

      final isPaymentSummary = controller.currentStep.value == 4;

      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12.r,
                offset: Offset(0, -5.h),
              ),
            ],
          ),
          child: isPaymentSummary
              ? _paymentBottom()
              : _continueButton(text: 'Continue', icon: Icons.arrow_forward),
        ),
      );
    });
  }

  Widget _continueButton({required String text, required IconData icon}) {
    return GestureDetector(
      onTap: controller.nextStep,
      child: Container(
        height: 52.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppTextStyles.xs12SemiBold.copyWith(
                color: Colors.white,
                letterSpacing: 0,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(icon, color: Colors.white, size: 16.sp),
          ],
        ),
      ),
    );
  }

  Widget _paymentBottom() {
    return Container(
      height: 66.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.priceText(controller.total),
                  style: AppTextStyles.sm14SemiBold.copyWith(
                    color: Colors.white,
                    letterSpacing: 0,
                  ),
                ),
                Text(
                  'Total Price',
                  style: AppTextStyles.xxs9Regular.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: controller.nextStep,
            child: Container(
              height: 44.h,
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              decoration: BoxDecoration(
                color: AppColors.actionPrimary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Text(
                    'Checkout',
                    style: AppTextStyles.xs12SemiBold.copyWith(
                      color: Colors.white,
                      letterSpacing: 0,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.shopping_cart_checkout_rounded,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final String title;
  final String trailing;
  final IconData? icon;
  final VoidCallback onTap;

  const _PaymentMethodTile({
    required this.title,
    required this.trailing,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.xs12Medium.copyWith(
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
            ),
            if (icon != null) Icon(icon, size: 16.sp),
            SizedBox(width: 4.w),
            Text(
              trailing,
              style: AppTextStyles.xs12SemiBold.copyWith(
                color: trailing.toLowerCase().contains('stripe')
                    ? const Color(0xFF635BFF)
                    : AppColors.textPrimary,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

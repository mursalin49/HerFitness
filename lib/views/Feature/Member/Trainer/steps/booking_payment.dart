import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../controllers/member/book_trainer_controller.dart';
import '../../../../../utils/AppColor/app_colors.dart';
import '../../../../../utils/AppTextStyle/app_text_styles.dart';
import '../../../../Base/CustomTextfield/CustomTextfield.dart';
import '../widgets/booking_trainer_summary.dart';

class BookingPayment extends StatelessWidget {
  final BookTrainerController controller;
  const BookingPayment({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 120.h, left: 16.w, right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BookingTrainerSummary(),
          SizedBox(height: 24.h),
          
          Text("Enter Coupon", style: AppTextStyles.base16Medium.copyWith(color: AppColors.textPrimary)),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: controller.couponController,
                  hintText: "Firsttime20",
                  prefixIcon: Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
                  filColor: Colors.white,
                  contentPaddingVertical: 14,
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: () {

                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Center(
                    child: Text("Use", style: AppTextStyles.base16Medium.copyWith(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          Text("Summary", style: AppTextStyles.base16Medium.copyWith(color: AppColors.textPrimary)),
          
          SizedBox(height: 16.h),
          Obx(() => _buildSummaryActionRow(Icons.calendar_today_outlined, "Service Date: ${DateFormat('MMMM dd, yyyy').format(controller.selectedDate.value)}")),
          SizedBox(height: 16.h),
          Obx(() => _buildSummaryActionRow(Icons.access_time, "Service Time: ${controller.selectedTime.value} ${controller.selectedPeriod.value}")),
          
          SizedBox(height: 24.h),
          Text("Payment Detail", style: AppTextStyles.base16Bold.copyWith(color: AppColors.textPrimary)),
          SizedBox(height: 12.h),
          
          _buildPaymentRow("1x Training", "\$20.00"),
          SizedBox(height: 12.h),
          _buildPaymentRow("Discount (10%)", "\$25.00", isLight: true),
          SizedBox(height: 12.h),
          _buildPaymentRow("Tax (2.5%)", "\$6.25", isLight: true),
          SizedBox(height: 12.h),
          Divider(color: Colors.grey, thickness: 1.h),
          SizedBox(height: 12.h),
          _buildPaymentRow("Total", "\$60.26", isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryActionRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textTertiary, size: 20.sp),
        SizedBox(width: 12.w),
        Text(text, style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildPaymentRow(String label, String value, {bool isLight = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: (isTotal ? AppTextStyles.base16Medium : AppTextStyles.sm14Medium).copyWith(color: isLight ? AppColors.textTertiary : AppColors.textPrimary)),
        Text(value, style: (isTotal ? AppTextStyles.base16Medium : AppTextStyles.sm14Medium).copyWith(color: AppColors.textPrimary)),
      ],
    );
  }
}

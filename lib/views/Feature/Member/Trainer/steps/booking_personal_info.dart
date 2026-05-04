import 'package:fitness/views/Base/CustomTextfield/CustomTextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../controllers/member/book_trainer_controller.dart';
import '../../../../../utils/AppColor/app_colors.dart';
import '../../../../../utils/AppTextStyle/app_text_styles.dart';
import '../widgets/booking_trainer_summary.dart';

class BookingPersonalInfo extends StatelessWidget {
  final BookTrainerController controller;
  const BookingPersonalInfo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 120.h, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BookingTrainerSummary(),
          SizedBox(height: 20.h),
          _buildLabel("Full Name"),
          CustomTextField(
            controller: controller.fullNameController,
            hintText: "Jane Cooper",
            prefixIcon: Icon(Icons.person_outline, color: AppColors.textTertiary, size: 20.sp),
          ),
          _buildLabel("Email"),
          CustomTextField(
            controller: controller.emailController,
            hintText: "danghoang87hl@gmail.com",
            prefixIcon: Icon(Icons.mail_outline, color: AppColors.textTertiary, size: 20.sp),
            isEmail: true,
          ),
          _buildLabel("Phone Number"),
          CustomTextField(
            controller: controller.phoneController,
            hintText: "(907) 555-0101",
            prefixIcon: Icon(Icons.phone_outlined, color: AppColors.textTertiary, size: 20.sp),
            keyboardType: TextInputType.phone,
          ),
          _buildLabel("Location"),
          CustomTextField(
            controller: controller.locationController,
            hintText: "Syracuse, Connecticut",
            prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.textTertiary, size: 20.sp),
          ),
          SizedBox(height: 24.h),
          Text("Additional Information", style: AppTextStyles.base16Bold.copyWith(color: AppColors.textPrimary)),

          _buildLabel("Comment"),
          CustomTextField(
            controller: controller.commentController,
            hintText: "18 y",
            maxLines: 4,
            suffixIcon: Padding(
              padding: EdgeInsets.all(12.r),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.description, color: AppColors.textTertiary, size: 16.sp),
                  SizedBox(width: 4.w),
                  Text("2/10", style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textTertiary, fontSize: 10.sp)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only( top: 16.h, bottom: 8.h),
      child: Text(text, style: AppTextStyles.base16Medium.copyWith(color: AppColors.textPrimary)),
    );
  }
}

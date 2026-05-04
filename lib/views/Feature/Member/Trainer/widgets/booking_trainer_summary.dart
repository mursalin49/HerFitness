import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/AppColor/app_colors.dart';
import '../../../../../utils/AppTextStyle/app_text_styles.dart';

class BookingTrainerSummary extends StatelessWidget {
  const BookingTrainerSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.network(
              "https://as1.ftcdn.net/jpg/02/26/49/16/1000_F_226491635_4Qp2RzkMlglsfSLIzXjLeRmqdTnaD4p8.jpg",
              width: 80.w,
              height: 80.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Seraphina Dubois", style: AppTextStyles.base16Bold.copyWith(color: AppColors.textPrimary)),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text("4.5", style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textPrimary)),
                    SizedBox(width: 12.w),
                    Icon(Icons.people, color: AppColors.actionPrimary, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text("21 Clients", style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: AppColors.textTertiary, size: 16.sp),
        ],
      ),
    );
  }
}

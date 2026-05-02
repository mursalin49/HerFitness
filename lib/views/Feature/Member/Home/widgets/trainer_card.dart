import 'package:fitness/utils/AppColor/app_colors.dart';
import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrainerCard extends StatelessWidget {
  final String name;
  final String expertise;
  final double rating;
  final String price;
  final String imageUrl;
  final VoidCallback? onTap;

  const TrainerCard({
    super.key,
    required this.name,
    required this.expertise,
    required this.rating,
    required this.price,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.bgTertiary,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                imageUrl,
                height: 70.h,
                width: 75.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.base16Bold.copyWith(color: AppColors.textPrimary),
                  ),
                  Text(
                    expertise,
                    style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textSecondary),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14.sp, color: Colors.amber),
                      SizedBox(width: 4.w),
                      Text(
                        "$rating",
                        style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textSecondary),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        price,
                        style: AppTextStyles.sm14Bold.copyWith(color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColors.textPrimary),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }
}

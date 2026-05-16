import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../controllers/member/book_trainer_controller.dart';
import '../../../../../utils/AppColor/app_colors.dart';
import '../../../../../utils/AppTextStyle/app_text_styles.dart';
import '../widgets/booking_trainer_summary.dart';

class BookingSessionSelect extends StatelessWidget {
  final BookTrainerController controller;

  const BookingSessionSelect({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 116.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookingTrainerSummary(controller: controller),
          SizedBox(height: 18.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Set reminder',
                style: AppTextStyles.xs12SemiBold.copyWith(
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              Obx(
                () => Switch.adaptive(
                  value: controller.isReminderEnabled.value,
                  onChanged: (value) =>
                      controller.isReminderEnabled.value = value,
                  activeThumbColor: AppColors.actionPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          ...List.generate(
            controller.sessions.length,
            (index) => Obx(
              () => _SessionCard(
                session: controller.sessions[index],
                selected: controller.selectedSessionIndex.value == index,
                onTap: () => controller.setSessionIndex(index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final Map<String, dynamic> session;
  final bool selected;
  final VoidCallback onTap;

  const _SessionCard({
    required this.session,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: selected ? AppColors.actionPrimary : AppColors.borderPrimary,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.borderFocusEffect,
                    blurRadius: 0,
                    spreadRadius: 3.w,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              session['title']?.toString() ?? 'Session',
              style: AppTextStyles.xs12SemiBold.copyWith(
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                _Meta(
                  icon: Icons.calendar_month_outlined,
                  text: session['date'],
                ),
                SizedBox(width: 16.w),
                _Meta(icon: Icons.schedule_rounded, text: session['time']),
              ],
            ),
            SizedBox(height: 8.h),
            _Meta(icon: Icons.location_on_outlined, text: session['location']),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.bgTertiary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  _InfoBlock(label: 'Class typ', value: session['classType']),
                  _InfoBlock(label: 'Session Format', value: session['format']),
                  _InfoBlock(
                    label: 'Per Member',
                    value: '\$${session['price']}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final Object? text;

  const _Meta({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: AppColors.textTertiary),
        SizedBox(width: 5.w),
        Text(
          text?.toString() ?? '',
          style: AppTextStyles.xxs9Medium.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String label;
  final Object? value;

  const _InfoBlock({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.xxs9Regular.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 0,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            value?.toString() ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.xxs9SemiBold.copyWith(
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}

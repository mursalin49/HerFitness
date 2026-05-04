import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../controllers/member/book_trainer_controller.dart';
import '../../../../../utils/AppColor/app_colors.dart';
import '../../../../../utils/AppTextStyle/app_text_styles.dart';
import '../widgets/booking_trainer_summary.dart';

class BookingDateTime extends StatelessWidget {
  final BookTrainerController controller;
  const BookingDateTime({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 120.h, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BookingTrainerSummary(),


          SizedBox(height: 24.h),
          Text("Select Date", style: AppTextStyles.base16Bold.copyWith(color: AppColors.textPrimary)),

          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildLegend(const Color(0xFF333333), "Not Available"),
              SizedBox(width: 24.w),
              _buildLegend(AppColors.actionPrimary, "Available"),
            ],
          ),
          SizedBox(height: 10),
          _buildCalendar(),
          SizedBox(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Select Time", style: AppTextStyles.base16Bold.copyWith(color: AppColors.textPrimary)),
              _buildAmPmToggle(),
            ],
          ),
          SizedBox(height: 16.h),
          _buildTimeSlots(),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Obx(() => Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: controller.focusedDate.value,
        selectedDayPredicate: (day) => isSameDay(controller.selectedDate.value, day),
        onDaySelected: (selectedDay, focusedDay) {
          controller.selectedDate.value = selectedDay;
          controller.focusedDate.value = focusedDay;
        },
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppColors.actionPrimary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: AppColors.actionPrimary,
            shape: BoxShape.circle,
          ),
          defaultTextStyle: AppTextStyles.sm14Medium.copyWith(color: AppColors.textPrimary),
          weekendTextStyle: AppTextStyles.sm14Medium.copyWith(color: AppColors.textPrimary),
          outsideTextStyle: AppTextStyles.sm14Medium.copyWith(color: AppColors.textTertiary),
          markersMaxCount: 1,
          markerDecoration: BoxDecoration(
            color: AppColors.actionPrimary,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: AppTextStyles.base16Bold.copyWith(color: AppColors.textPrimary),
          leftChevronIcon: Icon(Icons.chevron_left, color: AppColors.textPrimary),
          rightChevronIcon: Icon(Icons.chevron_right, color: AppColors.textPrimary),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: AppTextStyles.sm14Medium.copyWith(color: AppColors.textTertiary),
          weekendStyle: AppTextStyles.sm14Medium.copyWith(color: AppColors.textTertiary),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            bool isNotAvailable = day.day >= 9 && day.day <= 15;
            if (isNotAvailable) {
              return Container(
                margin: const EdgeInsets.all(6.0),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFF333333),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${day.day}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            return null;
          },
        ),
      ),
    ));
  }

  Widget _buildLegend(Color color, String text) {
    return Row(
      children: [
        Container(width: 12.w, height: 12.w, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 8.w),
        Text(text, style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textSecondary, fontSize: 12.sp)),
      ],
    );
  }

  Widget _buildAmPmToggle() {
    return Obx(() => Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _buildToggleItem("AM"),
          _buildToggleItem("PM"),
        ],
      ),
    ));
  }

  Widget _buildToggleItem(String label) {
    bool isSelected = controller.selectedPeriod.value == label;
    return GestureDetector(
      onTap: () => controller.selectedPeriod.value = label,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.actionPrimary.withValues(alpha: 0.4) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          label,
          style: AppTextStyles.sm14Medium.copyWith(
            color: isSelected ? AppColors.actionPrimary : AppColors.textTertiary,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSlots() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: controller.availableSlots.map((time) {
            bool isSelected = controller.selectedTime.value == time;
            return GestureDetector(
              onTap: () => controller.selectedTime.value = time,
              child: Container(
                width: 80.w,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    time,
                    style: AppTextStyles.sm14Medium.copyWith(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}

import 'package:intl/intl.dart';
import 'package:fitness/controllers/member/my_classes_controller.dart';
import 'package:fitness/utils/AppColor/app_colors.dart';
import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MemberMyClassesScreen extends StatelessWidget {
  MemberMyClassesScreen({super.key});

  final MyClassesController controller = Get.put(MyClassesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  _buildFilters(),
                  SizedBox(height: 24.h),
                  Text(
                    "All Schedules",
                    style: AppTextStyles.base16Bold.copyWith(color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: Obx(() => ListView.separated(
                          padding: EdgeInsets.only(bottom: 150.h),
                          itemCount: controller.filteredSchedules.length,
                          separatorBuilder: (context, index) => SizedBox(height: 16.h),
                          itemBuilder: (context, index) {
                            final schedule = controller.filteredSchedules[index];
                            return _buildClassCard(context, schedule);
                          },
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: 50.h, bottom: 20.h, left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        color: AppColors.actionPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back_ios_new, size: 20.sp, color: AppColors.textPrimary),
            ),
          ),
          Text(
            "My Classes",
            style: AppTextStyles.xl20Bold.copyWith(color: Colors.white),
          ),
          SizedBox(width: 20.w),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: controller.filters.map((filter) {
          return Obx(() {
            bool isSelected = controller.selectedFilter.value == filter;
            return GestureDetector(
              onTap: () => controller.setFilter(filter),
              child: Container(
                margin: EdgeInsets.only(right: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.actionPrimary : Colors.white,
                  borderRadius: BorderRadius.circular(13.r),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : AppColors.borderPrimary,
                  ),
                ),
                child: Text(
                  filter,
                  style: AppTextStyles.base16Medium.copyWith(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            );
          });
        }).toList(),
      ),
    );
  }

  Widget _buildClassCard(BuildContext context, Map<String, dynamic> schedule) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.bgTertiary,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.borderPrimary)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            schedule["title"],
            style: AppTextStyles.lg18Bold.copyWith(color: AppColors.textPrimary),
          ),
          SizedBox(height: 4.h),
          Text(
            "With ${schedule["trainer"]}",
            style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                _buildInfoRow(Icons.calendar_today_outlined, schedule["date"]),
                SizedBox(height: 12.h),
                _buildInfoRow(Icons.access_time, schedule["time"]),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          _buildActionButtons(context, schedule["status"]),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: AppColors.actionPrimary),
        SizedBox(width: 12.w),
        Text(
          text,
          style: AppTextStyles.base16Bold.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, String status) {
    if (status == "Completed") {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.statusSuccess.withOpacity(0.1)),
        ),
        child: Center(
          child: Text(
            "Completed",
            style: AppTextStyles.base16Medium.copyWith(color: AppColors.statusSuccess),
          ),
        ),
      );
    } else if (status == "Pending") {
      return Row(
        children: [
          Expanded(
            child: _buildSmallButton("Rescheduled", Colors.white, AppColors.textDisabled, isBordered: true),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildSmallButton("Check In", AppColors.actionSecondary, Colors.white),
          ),
        ],
      );
    } else {
      // Upcoming
      return Row(
        children: [
          Expanded(
            child: _buildSmallButton("Cancel", Colors.white, AppColors.textPrimary, isBordered: true),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: () => _showRescheduleModal(context),
              child: _buildSmallButton("Rescheduled", AppColors.actionSecondary, Colors.white),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildSmallButton(String text, Color bgColor, Color textColor, {bool isBordered = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: isBordered ? Border.all(color: AppColors.borderPrimary) : null,
      ),
      child: Center(
        child: Text(
          text,
          style: AppTextStyles.base16Bold.copyWith(color: textColor),
        ),
      ),
    );
  }

  void _showRescheduleModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              topRight: Radius.circular(40.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reschedule Booking",
                    style: AppTextStyles.lg18Bold.copyWith(color: AppColors.textPrimary),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFF9F9F9),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.actionPrimary,
                            blurRadius: 0,
                            offset: const Offset(0, 3),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.close, size: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Text("New Date", style: AppTextStyles.base16Bold),
              SizedBox(height: 8.h),
              Obx(() => _buildModalField(
                controller.selectedRescheduleDate.value,
                Icons.calendar_today_outlined,
                () => _pickDate(context),
              )),
              SizedBox(height: 24.h),
              Text("New Time", style: AppTextStyles.base16Bold),
              SizedBox(height: 8.h),
              Obx(() => _buildModalField(
                controller.selectedRescheduleTime.value,
                Icons.access_time,
                () => _pickTime(context),
              )),
              SizedBox(height: 32.h),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: AppColors.actionSecondary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      "Confirm Reschedule",
                      style: AppTextStyles.base16Bold.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModalField(String value, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderPrimary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: AppTextStyles.sm14Medium.copyWith(
                color: value.contains("/") || value.contains(":")
                    ? AppColors.textPrimary
                    : AppColors.textDisabled,
              ),
            ),
            Icon(icon, color: AppColors.textPrimary, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.actionPrimary),
          textTheme: Theme.of(context).textTheme.copyWith(
            headlineMedium: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
            ),
            headlineSmall: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (pickedDate != null) {
      controller.updateRescheduleDate(DateFormat('MM/dd/yyyy').format(pickedDate));
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.actionPrimary,
            primaryContainer: AppColors.actionPrimary,
            onPrimaryContainer: Colors.white,
            secondary: AppColors.actionPrimary,
            secondaryContainer: AppColors.actionPrimary,
            onSecondaryContainer: Colors.white,
            surface: Colors.white,
          ),
          textTheme: Theme.of(context).textTheme.copyWith(
            displayLarge: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w600,
              letterSpacing: -1,
            ),
            bodyLarge: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            bodyMedium: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (pickedTime != null) {
      final now = DateTime.now();
      final dt = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      controller.updateRescheduleTime(DateFormat('hh:mm a').format(dt));
    }
  }
}

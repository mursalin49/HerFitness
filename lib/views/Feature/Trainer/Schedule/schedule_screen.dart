import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:fitness/views/Base/AppText/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utils/AppColor/app_colors.dart';
import 'widgets/custom_schedule_card.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int selectedDateIndex = 0;
  List<DateTime> weekDates = List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
  String displayMonthYear = DateFormat('MMMM yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              children: [
                const CustomScheduleCard(
                  timeText: "16:00",
                  ampm: "AM",
                  title: "Team Meeting",
                  duration: "45 min",
                  isCompleted: true,
                  isBooked: true,
                ),
                SizedBox(height: 16.h),
                const CustomScheduleCard(
                  timeText: "16:00",
                  ampm: "AM",
                  title: "Team Meeting",
                  duration: "60 min",
                  isCompleted: false,
                  isBooked: true,
                ),
                SizedBox(height: 16.h),
                const CustomScheduleCard(
                  timeText: "10:00",
                  ampm: "AM",
                  isBooked: false,
                ),
                SizedBox(height: 16.h),
                const CustomScheduleCard(
                  timeText: "16:00",
                  ampm: "AM",
                  title: "Team Meeting",
                  duration: "60 min",
                  isCompleted: false,
                  isBooked: true,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16.h, bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.actionPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: const Center(child: Icon(Icons.arrow_back_ios_new, size: 20)),
                  ),
                ),
                AppText(
                  "Schedule",
                  style: AppTextStyles.xl20Medium.copyWith(color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: const Center(child: Icon(Icons.add, size: 28, color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.020),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AppText(
              displayMonthYear,
              style: AppTextStyles.base16Medium.copyWith(color: AppColors.textInverse),
            ),
          ),
          SizedBox(height: 12.h),

          /// Horizontal Dates Strip
          SizedBox(
            height: 105.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              itemCount: weekDates.length,
              itemBuilder: (context, index) {
                DateTime date = weekDates[index];
                String dayName = DateFormat('EEE').format(date);
                String dayNumber = DateFormat('d').format(date);
                
                return _buildDateItem(
                  day: dayName,
                  date: dayNumber,
                  isSelected: index == selectedDateIndex,
                  onTap: () {
                    setState(() {
                      selectedDateIndex = index;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateItem({required String day, required String date, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 65.w,
        margin: EdgeInsets.only(right: 8.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFE06F83).withOpacity(0.8),
          borderRadius: BorderRadius.circular(35),
          border: isSelected ? Border.all(color: const Color(0xFFE06F83), width: 1) : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.4),
                    spreadRadius: 4,
                    blurRadius: 0,
                    offset: const Offset(0, 0),
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              day,
              style: AppTextStyles.xs12Regular.copyWith(
                color: isSelected ? Colors.black87 : Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            AppText(
              date,
              style: AppTextStyles.base16Medium.copyWith(
                color: isSelected ? Colors.black87 : Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFFFA6A85) : Colors.white.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

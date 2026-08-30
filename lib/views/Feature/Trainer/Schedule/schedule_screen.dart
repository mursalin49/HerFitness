import 'package:fitness/controllers/my_classes_controller.dart';
import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:fitness/views/Base/AppText/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utils/AppColor/app_colors.dart';
import '../Classes/widgets/create_class_bottom_sheet.dart';
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
  late final MyClassesController classesController;

  @override
  void initState() {
    super.initState();
    classesController = Get.isRegistered<MyClassesController>()
        ? Get.find<MyClassesController>()
        : Get.put(MyClassesController());
  }

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
                Obx(() {
                  final selectedDate = weekDates[selectedDateIndex];
                  final dayClasses = classesController.classes.where((item) {
                    final startDateTime = item['startDateTime'];
                    if (startDateTime is! DateTime) return false;

                    return startDateTime.year == selectedDate.year &&
                        startDateTime.month == selectedDate.month &&
                        startDateTime.day == selectedDate.day;
                  }).toList();

                  if (classesController.isLoading.value && dayClasses.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.h),
                        child: CircularProgressIndicator(
                          color: AppColors.actionPrimary,
                        ),
                      ),
                    );
                  }

                  if (dayClasses.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 80.h),
                      child: Center(
                        child: AppText(
                          "No classes scheduled for this day",
                          style: AppTextStyles.sm14Medium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: List.generate(dayClasses.length, (index) {
                      final item = dayClasses[index];
                      final timeParts = _splitTime(item['time']?.toString());

                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: CustomScheduleCard(
                          timeText: timeParts.$1,
                          ampm: timeParts.$2,
                          title: item['title']?.toString() ?? 'Class',
                          duration: "${item['duration'] ?? '--'} min",
                          isCompleted: false,
                          isBooked: true,
                        ),
                      );
                    }),
                  );
                }),
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
                  onTap: _openCreateSheet,
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

  (String, String) _splitTime(String? value) {
    if (value == null || value.isEmpty || value == 'N/A') return ('--:--', '');

    final parts = value.split(' ');
    if (parts.length < 2) return (value, '');

    return (parts.first, parts.last);
  }

  void _openCreateSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CreateClassBottomSheet(),
    );
  }

}

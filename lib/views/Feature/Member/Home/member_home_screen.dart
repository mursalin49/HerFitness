import 'package:fitness/controllers/member/member_home_controller.dart';
import 'package:fitness/utils/AppColor/app_colors.dart';
import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness/views/Feature/Member/Home/widgets/trainer_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../Helpers/route.dart';
import '../../../Base/AppText/appText.dart';

import '../../../../Helpers/route.dart';

class MemberHomeScreen extends StatelessWidget {
  MemberHomeScreen({super.key});

  final MemberHomeController controller = Get.put(MemberHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                children: [
                  _buildCategories(),
                  SizedBox(height: 32.h),
                  _buildSectionHeader("My Next Workouts", () {}),
                  SizedBox(height: 16.h),
                  _buildNextWorkoutCard(),
                  SizedBox(height: 32.h),
                  _buildSectionHeader("Nearby Trainer", () => Get.toNamed(AppRoutes.trainerListScreen)),
                  SizedBox(height: 16.h),
                  _buildTrainerList(),
                  SizedBox(height: 130.h),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, MediaQuery.of(context).padding.top + 16.h, 20.w, 24.h,),
      decoration: BoxDecoration(
        color: AppColors.actionPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      child: Row(
        children: [
          // Profile Image
          GestureDetector(
            onTap: (){
              Get.toNamed(AppRoutes.trainerProfileScreen);
            },
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
                border: Border.all(color: Colors.white, width: 2),
                image: const DecorationImage(
                  image: NetworkImage("https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          // Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  "Welcome back",
                  style: AppTextStyles.xs12Regular.copyWith(color: Colors.white.withOpacity(0.8)),
                ),
                AppText(
                  "Alex Johnson",
                  style: AppTextStyles.base16SemiBold.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          // Notification Icon
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.notificationScreen),
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/notificationIcon.svg",
                  width: 24.w,
                  height: 24.w,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: controller.categories.map((category) {
          return Obx(() {
            bool isSelected = controller.selectedCategory.value == category;
            return GestureDetector(
              onTap: () => controller.setCategory(category),
              child: Container(
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.actionPrimary : Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: isSelected ? null : Border.all(color: AppColors.borderPrimary),
                ),
                child: Text(
                  category,
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



  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.lg18Bold.copyWith(color: AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildNextWorkoutCard() {
    return GestureDetector(
      onTap: () => _showWorkoutDetailsBottomSheet(),
      child: Container(
        width: double.infinity,
        height: 240.h,
      decoration: BoxDecoration(
        color: AppColors.bgTertiary,
        borderRadius: BorderRadius.all( Radius.circular(32.r)),
      ),
      child: Stack(
        children: [
          Positioned(
            child: ClipRRect(
              borderRadius: BorderRadius.all( Radius.circular(32.r)),
              child: Image.network(
                "https://eu.manduka.com/cdn/shop/articles/yogday.jpg?v=1718901651",
                height: 240.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildIconLabel(Icons.calendar_today_outlined, "10-04-2026"),
                    SizedBox(width: 16.w),
                    _buildIconLabel(Icons.access_time, "30min"),
                  ],
                ),
                const Spacer(),
                Text(
                  "Yoga Flow",
                  style: AppTextStyles.xl20Bold.copyWith(color: AppColors.textPrimary, fontSize: 24.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  "5 Series Workout",
                  style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20.w,
            bottom: 20.h,
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.actionPrimary,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(Icons.arrow_forward, color: Colors.white, size: 24.sp),
            ),
          ),
        ],
      ),
    )
    );
  }

  Widget _buildIconLabel(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: AppColors.actionSecondary),
        SizedBox(width: 6.w),
        Text(
          text,
          style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildTrainerList() {
    return Obx(() => Column(
      children: controller.trainers.map((trainer) {
        return TrainerCard(
          name: trainer["name"] as String,
          expertise: trainer["expertise"] as String,
          rating: (trainer["rating"] as num).toDouble(),
          price: trainer["price"] as String,
          imageUrl: "https://as1.ftcdn.net/jpg/02/26/49/16/1000_F_226491635_4Qp2RzkMlglsfSLIzXjLeRmqdTnaD4p8.jpg",
          distance: trainer["location"] as String? ?? "500m",
          onTap: () {
            Get.toNamed(AppRoutes.trainerDetailsScreen);
          },
        );
      }).toList(),
    ));
  }

  void _showWorkoutDetailsBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 60.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: AppColors.borderPrimary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    "Your Next Workout",
                    style: AppTextStyles.base16SemiBold.copyWith(color: AppColors.textPrimary),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
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

              const TrainerCard(
                name: "Arnold Swarznibble",
                expertise: "HIIT Expert",
                rating: 4.5,
                reviewCount: 500,
                price: "20 / session",
                imageUrl: "https://as1.ftcdn.net/jpg/02/26/49/16/1000_F_226491635_4Qp2RzkMlglsfSLIzXjLeRmqdTnaD4p8.jpg",
                distance: "500m",
              ),
              SizedBox(height: 16.h),
              // Location & Time Card
              _buildDetailCard(
                icon: Icons.location_on_rounded,
                title: "Location & Time",
                children: [
                  Text(
                    "578 Boolean Ave, New York, NY, Turing St",
                    style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textSecondary),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.calendar_month, size: 20.sp, color: const Color(0xFF0284C7)),
                      SizedBox(width: 8.w),
                      Text(
                        "10-04-2026",
                        style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.access_time_filled, size: 20.sp, color: const Color(0xFF0284C7)),
                      SizedBox(width: 8.w),
                      Text(
                        "11:00 AM",
                        style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              // Phone Number Card
              _buildDetailCard(
                icon: Icons.phone_rounded,
                title: "Phone Number",
                children: [
                  Text(
                    "(406) 555-0120",
                    style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textSecondary),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "(225) 555-0118",
                    style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.bgTertiary,
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: AppColors.borderSecondary),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: const BoxDecoration(
                  color: Color(0xFF8E8E93),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Text(
                title,
                style: AppTextStyles.base16Medium.copyWith(color: AppColors.textPrimary),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: children,
          ),
        ],
      ),
    );
  }
}

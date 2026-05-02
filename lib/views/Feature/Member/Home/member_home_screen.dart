import 'package:fitness/controllers/member/member_home_controller.dart';
import 'package:fitness/utils/AppColor/app_colors.dart';
import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness/views/Feature/Member/Home/widgets/trainer_card.dart';
import 'package:get/get.dart';

class MemberHomeScreen extends StatelessWidget {
  MemberHomeScreen({super.key});

  final MemberHomeController controller = Get.put(MemberHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _buildHeader(),
              SizedBox(height: 24.h),
              _buildSearchBar(),
              SizedBox(height: 20.h),
              _buildCategories(),
              SizedBox(height: 24.h),
              _buildBanner(),
              SizedBox(height: 32.h),
              _buildSectionHeader("My Next Workouts", () {}),
              SizedBox(height: 16.h),
              _buildNextWorkoutCard(),
              SizedBox(height: 32.h),
              _buildSectionHeader("Find a Trainer", () {}),
              SizedBox(height: 16.h),
              _buildTrainerList(),
              SizedBox(height: 120.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundImage: NetworkImage("https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop")
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good afternoon Hamed",
                  style: AppTextStyles.base16Bold.copyWith(color: AppColors.textPrimary),
                ),
                Text(
                  "Sun, 24 April 2026",
                  style: AppTextStyles.sm14Regular.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Icons.notifications_none_rounded, size: 24.sp, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search gym, trainers, classess...",
          hintStyle: AppTextStyles.sm14Regular.copyWith(color: AppColors.textDisabled),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search, color: AppColors.textPrimary, size: 24.sp),
        ),
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
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
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

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        image: DecorationImage(
          image: NetworkImage("https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            colors: [
              Colors.black.withValues(alpha: 0.6),
              Colors.transparent,
            ],
          ),
        ),
        alignment: Alignment.bottomLeft,
        child: Text(
          "New features or\nevents in the gym",
          style: AppTextStyles.base16Bold.copyWith(color: Colors.white, fontSize: 18.sp),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.lg18Bold.copyWith(color: AppColors.textPrimary)),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "View all",
            style: AppTextStyles.sm14Medium.copyWith(color: AppColors.actionPrimary),
          ),
        ),
      ],
    );
  }

  Widget _buildNextWorkoutCard() {
    return Container(
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
          onTap: () {},
        );
      }).toList(),
    ));
  }

}

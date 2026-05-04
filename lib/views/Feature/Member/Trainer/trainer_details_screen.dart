import 'package:fitness/controllers/member/trainer_details_controller.dart';
import 'package:fitness/utils/AppColor/app_colors.dart';
import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:fitness/views/Base/CustomAppbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Helpers/route.dart';
import 'widgets/review_card.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TrainerDetailsScreen extends StatelessWidget {
  TrainerDetailsScreen({super.key});

  final TrainerDetailsController controller = Get.put(TrainerDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderImage(),
                SizedBox(height: 24.h),
                _buildStatsCard(),
                SizedBox(height: 24.h),
                _buildAvailabilitySection(),
                SizedBox(height: 24.h),
                _buildReviewsSection(),
                SizedBox(height: 24.h),
                _buildBioSection(),
                SizedBox(height: 24.h),
                _buildLocationSection(),
                SizedBox(height: 120.h),
              ],
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Stack(
      children: [
        Container(
          height: 400.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40.r)),
            image: const DecorationImage(
              image: NetworkImage("https://images.unsplash.com/photo-1518611012118-29a88f5573ce?q=80&w=800&auto=format&fit=crop"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Overlay Gradient for text readability
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40.r)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.2),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.6),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),
        // Top Buttons
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: CustomAppbar()
          ),
        ),
        // Bottom Text Info
        Positioned(
          left: 20.w,
          right: 20.w,
          bottom: 30.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Seraphina Dubois",
                style: AppTextStyles.base16Medium.copyWith(color: Colors.white, fontSize: 26.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                "\$100 - \$250/session",
                style: AppTextStyles.base16Medium.copyWith(color: Colors.white.withValues(alpha: 0.9)),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  _buildSmallTag(Icons.radar, "Yoga & Pilates"),
                  SizedBox(width: 16.w),
                  _buildSmallTag(Icons.location_on, "500m"),
                ],
              ),
            ],
          ),
        ),
        // Message Button
        Positioned(
          right: 20.w,
          bottom: 30.h,
          child: Container(
            width: 56.w,
            height: 56.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.chat_bubble, color: Colors.black, size: 24.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildCircleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black, size: 20.sp),
      ),
    );
  }

  Widget _buildSmallTag(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.actionPrimary, size: 18.sp),
        SizedBox(width: 6.w),
        Text(
          text,
          style: AppTextStyles.sm14Medium.copyWith(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(vertical: 24.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem("5y", "Experience"),
          _buildDivider(),
          _buildStatItem("88+", "Clients"),
          _buildDivider(),
          _buildStatItem("4.5", "Rating"),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.lg18Bold.copyWith(color: AppColors.textPrimary, fontSize: 22.sp)),
        SizedBox(height: 4.h),
        Text(label, style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textTertiary)),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40.h,
      width: 1,
      color: AppColors.borderPrimary,
    );
  }

  Widget _buildAvailabilitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.timeSlots.map((time) {
                return Obx(() {
                  bool isSelected = controller.selectedTimeSlot.value == time;
                  return GestureDetector(
                    onTap: () => controller.selectTimeSlot(time),
                    child: Container(
                      margin: EdgeInsets.only(right: 12.w),
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.actionPrimary : Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: isSelected ? AppColors.actionPrimary : AppColors.borderPrimary),
                      ),
                      child: Column(
                        children: [
                          Text(
                            time,
                            style: AppTextStyles.sm14Medium.copyWith(
                              color: isSelected ? Colors.white : AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            "Available",
                            style: AppTextStyles.sm14Medium.copyWith(
                              color: isSelected ? Colors.white.withValues(alpha: 0.8) : AppColors.textSecondary,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    final List<Map<String, String>> reviews = [
      {
        "name": "Charles D. Xavier",
        "rating": "4.5",
        "time": "3d ago",
        "text": "I've been practicing my glutes with coach Seraphina Dubois for the past week, and I feel better! The personalized recommendation is simply a beast!!",
        "image": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200&auto=format&fit=crop"
      },
      {
        "name": "Lena M. Carter",
        "rating": "4.8",
        "time": "1d ago",
        "text": "The yoga sessions with instructor Mateo Rivera have transformed my flexibility and mindset. Highly recommend his calming approach.",
        "image": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200&auto=format&fit=crop"
      },
      {
        "name": "Ethan J. Wang",
        "rating": "4.6",
        "time": "5h ago",
        "text": "Training with coach Aisha Khan has boosted my endurance significantly. The tailored cardio workouts keep me motivated every day.",
        "image": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200&auto=format&fit=crop"
      },
    ];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Reviews", style: AppTextStyles.base16Medium.copyWith(color: AppColors.textPrimary)),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.trainerReviewsScreen),
                child: Text("See all", style: AppTextStyles.sm14Medium.copyWith(color: AppColors.actionPrimary)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 210.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Container(
                width: 320.w,
                margin: EdgeInsets.only(right: 12.w),
                child: ReviewCard(
                  name: review["name"]!,
                  rating: review["rating"]!,
                  timeAgo: review["time"]!,
                  reviewText: review["text"]!,
                  imageUrl: review["image"]!,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBioSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Personal Bio", style: AppTextStyles.base16Medium.copyWith(color: AppColors.textPrimary)),
          SizedBox(height: 12.h),
          Text(
            "I've been practicing my glutes with coach Seraphina Dubois for the past week, and I feel better! The personalized recommendation is simply a beast!! I've been practicing my glutes with coach Seraphina Dubois for the past week, and I feel better!",
            style: AppTextStyles.sm14Regular.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Location", style: AppTextStyles.base16Medium.copyWith(color: AppColors.textPrimary)),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: SizedBox(
              height: 200.h,
              width: double.infinity,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(23.8103, 90.4125),
                  initialZoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png",
                    subdomains: const ['a', 'b', 'c', 'd'],
                    userAgentPackageName: 'com.sparktech.herfitness',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(23.8103, 90.4125),
                        width: 40.w,
                        height: 40.w,
                        child: Icon(
                          Icons.location_on,
                          color: AppColors.actionPrimary,
                          size: 40.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.bookTrainerScreen),
          child: Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Book now",
                  style: AppTextStyles.base16Medium.copyWith(color: Colors.white),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.calendar_month, color: Colors.white, size: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

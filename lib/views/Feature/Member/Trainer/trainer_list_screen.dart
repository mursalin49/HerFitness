import 'package:fitness/controllers/member/trainer_list_controller.dart';
import 'package:fitness/utils/AppColor/app_colors.dart';
import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:fitness/views/Base/CustomAppbar/custom_appbar.dart';
import 'package:fitness/views/Base/CustomTextfield/CustomTextfield.dart';
import 'package:fitness/views/Feature/Member/Home/widgets/trainer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../Helpers/route.dart';

class TrainerListScreen extends StatelessWidget {
  TrainerListScreen({super.key});

  final TrainerListController controller = Get.put(TrainerListController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Stack(
        children: [
          // Background Gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(1.0, -1.0),
                radius: 2.5,
                colors: [
                  const Color(0xFFFFA6B4).withOpacity(0.5),
                  const Color(0xFFFFE0B9).withOpacity(0.25),
                  Colors.white,
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const CustomAppbar(title: "Trainer"),
                ),
                SizedBox(height: 24.h),
                _buildTabs(),
                SizedBox(height: 16.h),
                Expanded(
                  child: Obx(() {
                    if (controller.selectedTab.value == "Search") {
                      return _buildSearchSection();
                    } else {
                      return _buildNearYouSection();
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(6.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFF2F2F2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Obx(() {
            bool isNearYou = controller.selectedTab.value == "Near You";
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isNearYou ? 0 : (MediaQuery.of(Get.context!).size.width - 52.w) / 2,
              right: isNearYou ? (MediaQuery.of(Get.context!).size.width - 52.w) / 2 : 0,
              top: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.actionPrimary,
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            );
          }),
          Row(
            children: [
              _buildTabItem("Near You"),
              _buildTabItem("Search"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setTab(title),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Center(
            child: Obx(() {
              bool isSelected = controller.selectedTab.value == title;
              return Text(
                title,
                style: AppTextStyles.base16SemiBold.copyWith(
                  color: isSelected ? Colors.white : AppColors.textTertiary,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNearYouSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "All Coaches",
                style: AppTextStyles.base16Medium.copyWith(color: AppColors.textPrimary),
              ),
              Row(
                children: [
                  Text(
                    "Most Popular",
                    style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textTertiary),
                  ),
                  SizedBox(width: 8.w),
                  SvgPicture.asset("assets/icons/radar.svg"),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.zero,
                child: TrainerCard(
                  name: "Arnold Swarznibble",
                  expertise: "Yoga Specialist",
                  rating: 4.5,
                  price: "\$100/session",
                  imageUrl: "https://as1.ftcdn.net/jpg/02/26/49/16/1000_F_226491635_4Qp2RzkMlglsfSLIzXjLeRmqdTnaD4p8.jpg",
                  distance: "500m",
                  reviewCount: 500,
                  onTap: () {
                    Get.toNamed(AppRoutes.trainerDetailsScreen);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomTextField(
            onChanged: controller.onSearch,
            hintText: "Search here",
            controller: searchController,
            suffixIcon: Icon(Icons.search),
          ),
        ),
        SizedBox(height: 24.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1 Result Found.",
                style: AppTextStyles.base16Medium.copyWith(color: AppColors.textPrimary),
              ),
              Row(
                children: [
                  Text(
                    "Most Popular",
                    style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textTertiary),
                  ),
                  SizedBox(width: 8.w),
                  SvgPicture.asset("assets/icons/radar.svg"),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemCount: 1,
            itemBuilder: (context, index) {
              return TrainerCard(
                name: "Arnold Swarznibble",
                expertise: "Yoga Specialist",
                rating: 4.5,
                price: "\$111/session",
                imageUrl: "https://as1.ftcdn.net/jpg/02/26/49/16/1000_F_226491635_4Qp2RzkMlglsfSLIzXjLeRmqdTnaD4p8.jpg",
                distance: "500m",
                reviewCount: 500,
                onTap: () {
                  Get.toNamed(AppRoutes.trainerDetailsScreen);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

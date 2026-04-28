import 'package:fitness/utils/AppColor/app_colors.dart';
import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:fitness/views/Base/AppText/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Helpers/route.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              children: [
                _buildSectionTitle("General"),
                _buildSettingItem(
                  icon: Icons.person_outline_rounded,
                  title: "Personal Information",
                  onTap: () => Get.toNamed(AppRoutes.personalInfoScreen),
                ),
                _buildSettingItem(
                  icon: Icons.notifications_none_rounded,
                  title: "Notifications settings",
                  onTap: () => Get.toNamed(AppRoutes.notificationSettingsScreen),
                ),
                _buildSettingItem(icon: Icons.credit_card_rounded, title: "Transactions", onTap: () {}),
                
                SizedBox(height: 24.h),
                _buildSectionTitle("Security & Privacy"),
                _buildSettingItem(icon: Icons.lock_outline_rounded, title: "Change Password", onTap: () {}),
                _buildSettingItem(icon: Icons.description_outlined, title: "Privacy Policy", onTap: () {}),
                _buildSettingItem(icon: Icons.gavel_outlined, title: "Terms of Service", onTap: () {}),
                
                SizedBox(height: 24.h),
                _buildSectionTitle("Help & Support"),
                _buildSettingItem(icon: Icons.info_outline_rounded, title: "About Us", onTap: () {}),
                _buildSettingItem(icon: Icons.chat_bubble_outline_rounded, title: "Help Center", onTap: () {}),
                
                SizedBox(height: 24.h),
                _buildSectionTitle("Danger Zone"),
                _buildDeleteAccountButton(),
                
                SizedBox(height: 24.h),
                _buildSectionTitle("Log Out"),
                _buildSettingItem(icon: Icons.logout_rounded, title: "Sign Out", onTap: () {}),
                
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        20.w,
        MediaQuery.of(context).padding.top + 16.h,
        20.w,
        24.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.actionPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Center(
                child: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: AppText(
                "Account Settings",
                style: AppTextStyles.base16SemiBold.copyWith(color: Colors.white, fontSize: 20.sp),
              ),
            ),
          ),
          SizedBox(width: 44.w)
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 4.w),
      child: AppText(
        title,
        style: AppTextStyles.base16SemiBold.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildSettingItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF1F1F1)),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: const Color(0xFFF1F1F1)),
          ),
          child: Icon(icon, color: AppColors.textPrimary, size: 22),
        ),
        title: AppText(
          title,
          style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textPrimary),
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildDeleteAccountButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ListTile(
        onTap: () {},
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: const Icon(Icons.lock_outline_rounded, color: Colors.white, size: 22),
        ),
        title: AppText(
          "Delete Account",
          style: AppTextStyles.sm14Medium.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white),
      ),
    );
  }
}

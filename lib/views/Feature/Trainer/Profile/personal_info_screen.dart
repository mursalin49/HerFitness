import 'package:fitness/utils/AppColor/app_colors.dart';
import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:fitness/views/Base/AppText/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Base/AppButton/appButton.dart';
import '../../../Base/CustomTextfield/CustomTextfield.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _certController = TextEditingController();
  final TextEditingController _hostModeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _stateController.dispose();
    _bioController.dispose();
    _durationController.dispose();
    _certController.dispose();
    _hostModeController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),

                  _buildLabel("Full Name"),
                  CustomTextField(
                    prefixIcon: Icon(Icons.person_outline_rounded, size: 20.w),
                    hintText: "Enter your name",
                    controller: _nameController,
                  ),
                  SizedBox(height: 16.h),
                  
                  _buildLabel("Email Address"),
                  CustomTextField(
                    prefixIcon: Icon(Icons.email_outlined, size: 20.w),
                    hintText: "Enter your E-mail",
                    controller: _emailController,
                  ),
                  SizedBox(height: 16.h),
                  
                  _buildLabel("Phone number"),
                  CustomTextField(
                    prefixIcon: Icon(Icons.phone_outlined, size: 20.w),
                    hintText: "(229) 555-0109",
                    controller: _phoneController,
                  ),
                  SizedBox(height: 16.h),
                  
                  _buildLabel("Your state"),
                  CustomTextField(
                    hintText: "Enter your state",
                    controller: _stateController,
                  ),
                  SizedBox(height: 16.h),
                  
                  _buildLabel("Personal Bio"),
                  CustomTextField(
                    maxLines: 4,
                    hintText: "e.g. NASM CPT",
                    controller: _bioController,
                  ),
                  SizedBox(height: 16.h),
                  
                  _buildLabel("What fitness classes do you teach?"),
                  _buildTeachClassesField(),
                  SizedBox(height: 16.h),
                  
                  _buildLabel("How long have you been an instructor?"),
                  CustomTextField(
                    prefixIcon: Icon(Icons.calendar_month_outlined, size: 20.w),
                    hintText: "2yr",
                    controller: _durationController,
                  ),
                  SizedBox(height: 16.h),
                  
                  _buildLabel("What certifications/qualifications do you have?"),
                  CustomTextField(
                    maxLines: 4,
                    hintText: "e.g. NASM CPT",
                    controller: _certController,
                  ),
                  SizedBox(height: 16.h),
                  
                  _buildLabel("Do you host classes online or in person?"),
                  CustomTextField(
                    hintText: "e.g. Online, In person, or Both",
                    suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 20.w),
                    controller: _hostModeController,
                  ),
                  SizedBox(height: 16.h),
                  
                  _buildLabel("Location"),
                  CustomTextField(
                    prefixIcon: Icon(Icons.location_on_outlined, size: 20.w),
                    hintText: "Syracuse, Connecticut",
                    controller: _locationController,
                  ),
                  SizedBox(height: 32.h),
                  
                  AppButton(
                    onTap: () {},
                    text: "Save Settings",
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 160.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              20.w,
              0,
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
                      "Personal Info",
                      style: AppTextStyles.base16SemiBold.copyWith(color: Colors.white, fontSize: 20.sp),
                    ),
                  ),
                ),
                SizedBox(width: 44.w),
              ],
            ),
          ),
          Positioned(
            bottom: -45.h,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      image: const DecorationImage(
                        image: NetworkImage("https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop"),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.white, width: 4.w),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/editIcon.svg"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: AppText(
        text,
        style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildTeachClassesField() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.actionPrimary.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              _buildTag("Yoga"),
              SizedBox(width: 8.w),
              AppText(
                "Strength Training",
                style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textPrimary),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.description_outlined, size: 14.w, color: Colors.grey),
              SizedBox(width: 4.w),
              AppText(
                "2/10",
                style: AppTextStyles.xs12Regular.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.actionPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: AppText(
        text,
        style: AppTextStyles.xs12Regular.copyWith(color: AppColors.actionPrimary),
      ),
    );
  }
}

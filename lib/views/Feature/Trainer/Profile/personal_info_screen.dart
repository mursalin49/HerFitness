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
  final TextEditingController _tagController = TextEditingController();
  List<String> _teachClasses = ["Yoga", "Strength Training"];
  String? _selectedHostMode;
  final List<String> _hostModeOptions = ["Online", "In person", "Both"];

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
    _tagController.dispose();
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
                  SizedBox(height: 30),

                  _buildLabel("Full Name"),
                  CustomTextField(
                    prefixIcon: "assets/icons/personIcon.svg",
                    hintText: "Enter your name",
                    controller: _nameController,
                  ),
                  SizedBox(height: 16.h),
                  
                  _buildLabel("Email Address"),
                  CustomTextField(
                    hintText: "Enter your E-mail",
                    controller: _emailController,
                    prefixIcon: "assets/icons/emailIcon.svg",
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
                  DropdownButtonFormField<String>(
                    value: _selectedHostMode,
                    icon: Icon(Icons.keyboard_arrow_down_rounded, size: 20.w),
                    decoration: InputDecoration(
                      hintText: "e.g. Online, In person, or Both",
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: AppColors.actionPrimary),
                      ),
                    ),
                    items: _hostModeOptions.map((String mode) {
                      return DropdownMenuItem<String>(
                        value: mode,
                        child: AppText(mode, style: AppTextStyles.sm14Medium),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedHostMode = newValue;
                      });
                    },
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
            bottom: -50.h,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 87.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      image: const DecorationImage(
                        image: NetworkImage("https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop"),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.white, width: 2.w),
                    ),
                  ),
                  Positioned(
                    bottom: -20.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/editIcon.svg",
                            color: Colors.white,
                            width: 18.w,
                            height: 18.w,
                          ),
                        ),
                      ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ..._teachClasses.map((tag) => _buildDynamicTag(tag)),
              SizedBox(
                width: 100.w,
                child: TextField(
                  controller: _tagController,
                  style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textPrimary),
                  decoration: const InputDecoration(
                    hintText: "Add...",
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) {
                    if (value.endsWith(" ")) {
                      _addTag(value.trim());
                    }
                  },
                  onSubmitted: (value) {
                    _addTag(value.trim());
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.description_outlined, size: 14.w, color: Colors.grey),
              SizedBox(width: 4.w),
              AppText(
                "${_teachClasses.length}/10",
                style: AppTextStyles.xs12Regular.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addTag(String tag) {
    if (tag.isNotEmpty && _teachClasses.length < 10) {
      setState(() {
        if (!_teachClasses.contains(tag)) {
          _teachClasses.add(tag);
        }
        _tagController.clear();
      });
    } else {
      _tagController.clear();
    }
  }

  Widget _buildDynamicTag(String text) {
    return Container(
      padding: EdgeInsets.only(left: 12.w, right: 6.w, top: 4.h, bottom: 4.h),
      decoration: BoxDecoration(
        color: AppColors.actionPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            text,
            style: AppTextStyles.xs12Regular.copyWith(color: AppColors.actionPrimary, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: () {
              setState(() {
                _teachClasses.remove(text);
              });
            },
            child: Icon(Icons.close, size: 14.w, color: AppColors.actionPrimary),
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

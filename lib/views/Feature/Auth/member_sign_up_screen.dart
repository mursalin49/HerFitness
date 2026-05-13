import '../../Base/ProfilePicPicker/profile_pic_picker.dart';
import 'package:fitness/Helpers/route.dart';
import 'package:fitness/views/Base/AppButton/appButton.dart';
import 'package:fitness/views/Base/AppText/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/AppColor/app_colors.dart';
import '../../../utils/AppTextStyle/app_text_styles.dart';
import '../../Base/CustomTextfield/CustomTextfield.dart';

class MemberSignUpScreen extends StatefulWidget {
  const MemberSignUpScreen({super.key});

  @override
  State<MemberSignUpScreen> createState() => _MemberSignUpScreenState();
}

class _MemberSignUpScreenState extends State<MemberSignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void _continueToPasswordVerification() {
    final validationMessage = _validate();
    if (validationMessage != null) {
      Get.snackbar(
        'Registration incomplete',
        validationMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.toNamed(
      AppRoutes.passwordVerificationScreen,
      arguments: {
        'flow': 'signup',
        'role': 'member',
        'email': emailController.text.trim(),
      },
    );
  }

  String? _validate() {
    final requiredValues = {
      'name': nameController.text,
      'email': emailController.text,
      'phone number': phoneController.text,
      'state': stateController.text,
      'location': locationController.text,
      'password': passwordController.text,
      'confirm password': confirmPasswordController.text,
    };

    for (final entry in requiredValues.entries) {
      if (entry.value.trim().isEmpty) {
        return 'Please enter ${entry.key}.';
      }
    }

    if (passwordController.text != confirmPasswordController.text) {
      return 'Password and confirm password do not match.';
    }

    return null;
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: AppText(
        text,
        style: AppTextStyles.base16Medium.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(1.0, -1.0),
                radius: 2.5,
                colors: [
                  const Color(0xFFFFA6B4).withValues(alpha: 0.5),
                  const Color(0xFFFFE0B9).withValues(alpha: 0.25),
                  Colors.white,
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                  Image.asset("assets/images/sigupImg.png"),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  // Profile picture picker
                  ProfilePicPicker(
                    placeholderImage: "assets/images/memberImg.png",
                    onImagePicked: (file) {
                      // Handle picked file safely
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bgPrimary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      border: Border(
                        top: BorderSide(
                          color: AppColors.actionPrimary,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 18.h),

                          _buildLabel("Enter your name"),
                          CustomTextField(
                            hintText: 'Enter your name',
                            controller: nameController,
                            filColor: AppColors.bgPrimary,
                            borderColor: AppColors.actionPrimary,
                            prefixIcon: "assets/icons/personIcon.svg",
                          ),
                          SizedBox(height: 16.h),

                          _buildLabel("Enter your email"),
                          CustomTextField(
                            hintText: 'Enter your E-mail',
                            controller: emailController,
                            filColor: AppColors.bgPrimary,
                            borderColor: AppColors.actionPrimary,
                            prefixIcon: "assets/icons/emailIcon.svg",
                          ),
                          SizedBox(height: 16.h),

                          _buildLabel("Phone number"),
                          CustomTextField(
                            hintText: '(229) 555-0109',
                            controller: phoneController,
                            filColor: AppColors.bgPrimary,
                            borderColor: AppColors.actionPrimary,
                            prefixIcon: "assets/icons/phoneIcon.svg",
                          ),
                          SizedBox(height: 16.h),

                          _buildLabel("Your state"),
                          CustomTextField(
                            hintText: 'Select your state',
                            controller: stateController,
                            filColor: AppColors.bgPrimary,
                            borderColor: AppColors.actionPrimary,
                          ),
                          SizedBox(height: 16.h),

                          _buildLabel("Your location"),
                          CustomTextField(
                            hintText: 'Syracuse, Connecticut',
                            controller: locationController,
                            filColor: AppColors.bgPrimary,
                            borderColor: AppColors.actionPrimary,
                            prefixIcon: "assets/icons/locationIcon.svg",
                          ),
                          SizedBox(height: 16.h),

                          _buildLabel("Password"),
                          CustomTextField(
                            hintText: '******',
                            controller: passwordController,
                            filColor: AppColors.bgPrimary,
                            borderColor: AppColors.actionPrimary,
                            prefixIcon: "assets/icons/lock.svg",
                            isPassword: true,
                          ),
                          SizedBox(height: 16.h),

                          _buildLabel("Confirm Password"),
                          CustomTextField(
                            hintText: '******',
                            controller: confirmPasswordController,
                            filColor: AppColors.bgPrimary,
                            borderColor: AppColors.actionPrimary,
                            prefixIcon: "assets/icons/lock.svg",
                            isPassword: true,
                          ),
                          SizedBox(height: 12.h),

                          // Password strength indicator
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF7869A),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Container(
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5E7EB),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Container(
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5E7EB),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Container(
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5E7EB),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          AppText(
                            "Weak password! Let's add more strength!",
                            style: AppTextStyles.sm14Regular.copyWith(
                              color: const Color(0xFF6B7280), // Gray 500
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.040,
                          ),

                          AppButton(
                            text: "Sign up",
                            onTap: _continueToPasswordVerification,
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.040,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText(
                                "Don't have already an account? ", // Kept user's typo from screenshot
                                style: AppTextStyles.sm14Regular.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: AppText(
                                  "Login",
                                  style: AppTextStyles.sm14SemiBold.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.040,
                          ),
                        ],
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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    stateController.dispose();
    locationController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

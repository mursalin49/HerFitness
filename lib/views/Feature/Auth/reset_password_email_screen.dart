import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:fitness/views/Base/AppButton/appButton.dart';
import 'package:fitness/views/Base/AppText/appText.dart';
import 'package:fitness/views/Base/CustomAppbar/custom_appbar.dart';
import 'package:fitness/views/Base/CustomTextfield/CustomTextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/AppColor/app_colors.dart';
import 'package:fitness/Helpers/route.dart';

class ResetPasswordEmailScreen extends StatelessWidget {
  ResetPasswordEmailScreen({super.key});

  final TextEditingController emailController = TextEditingController();

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
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.045),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const CustomAppbar(),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                
                AppText(
                  "Forgot Password",
                  style: AppTextStyles.twoXL24Medium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: AppText(
                    "Please enter your email address to reset your password.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.base16Medium.copyWith(
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ),
                SizedBox(height: 48.h),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        "Enter your E-mail",
                        style: AppTextStyles.base16Medium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        hintText: "Enter your E-mail",
                        prefixIcon: "assets/icons/emailIcon.svg",
                        controller: emailController,
                        filColor: Colors.white,
                        borderColor: Colors.grey.shade300,
                      ),
                      SizedBox(height: 32.h),
                      AppButton(
                        text: "Reset Password",
                        onTap: () {
                          Get.toNamed(AppRoutes.otpVerificationScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

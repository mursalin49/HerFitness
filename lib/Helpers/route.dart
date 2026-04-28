import 'package:get/get.dart';
import '../views/Feature/Auth/sign_in_screen.dart';
import '../views/Feature/SplashScreen/splash_screen.dart';
import '../views/Feature/Auth/Welcome/welcome_screen.dart';
import '../views/Feature/Auth/role_selection_screen.dart';
import '../views/Feature/Auth/member_sign_up_screen.dart';
import '../views/Feature/Auth/trainer_sign_up_screen.dart';
import '../views/Feature/Auth/forgot_password_screen.dart';
import '../views/Feature/Auth/reset_password_email_screen.dart';
import '../views/Feature/Auth/otp_verification_screen.dart';
import '../views/Feature/Auth/change_password_screen.dart';
import '../views/Feature/Trainer/BottomNav/trainer_bottom_nav_screen.dart';
import '../views/Feature/Trainer/Profile/account_settings_screen.dart';
import '../views/Feature/Trainer/Profile/notification_settings_screen.dart';
import '../views/Feature/Trainer/Profile/personal_info_screen.dart';
import '../views/Feature/Trainer/Profile/trainer_profile_screen.dart';
import '../views/Feature/Trainer/Profile/change_password_screen.dart' as profile;
import '../views/Feature/Trainer/Schedule/schedule_screen.dart';
import '../views/Feature/common/notification_screen.dart';
import '../views/Feature/common/privacy_policy_screen.dart';
import '../views/Feature/common/terms_of_service_screen.dart';
import '../views/Feature/common/about_us_screen.dart';
import '../views/Feature/common/help_center_screen.dart';

class AppRoutes{
  static String splashScreen="/splash_screen";
  static String welcomeScreen="/welcome_screen";
  static String roleSelectionScreen="/role_selection_screen";
  static String signInScreen="/sign_in_screen";
  static String memberSignUpScreen="/member_sign_up_screen";
  static String trainerSignUpScreen="/trainer_sign_up_screen";
  static String forgotPasswordScreen="/forgot_password_screen";
  static String resetPasswordEmailScreen="/reset_password_email_screen";
  static String otpVerificationScreen="/otp_verification_screen";
  static String changePasswordScreen="/change_password_screen";
  static String scheduleScreen ="/schedule_screen";
  static String notificationScreen ="/notification_screen";
  static String trainerProfileScreen ="/trainer_profile_screen";
  static String accountSettingsScreen ="/account_settings_screen";
  static String personalInfoScreen ="/personal_info_screen";
  static String notificationSettingsScreen ="/notification_settings_screen";
  static String profileChangePasswordScreen ="/profile_change_password_screen";
  static String privacyPolicyScreen ="/privacy_policy_screen";
  static String termsOfServiceScreen ="/terms_of_service_screen";
  static String aboutUsScreen ="/about_us_screen";
  static String helpCenterScreen ="/help_center_screen";
  static String trainerBottomNavScreen="/trainer_bottom_nav_screen";

  static final List<GetPage>page=[
    GetPage(name: splashScreen, page: ()=> const SplashScreen()),
    GetPage(name: welcomeScreen, page: ()=> const WelcomeScreen()),
    GetPage(name: roleSelectionScreen, page: ()=> const RoleSelectionScreen()),
    GetPage(name: signInScreen, page: ()=> const SignInScreen()),
    GetPage(name: memberSignUpScreen, page: ()=> const MemberSignUpScreen()),
    GetPage(name: trainerSignUpScreen, page: ()=> const TrainerSignUpScreen()),
    GetPage(name: forgotPasswordScreen, page: ()=> const ForgotPasswordScreen()),
    GetPage(name: resetPasswordEmailScreen, page: ()=> ResetPasswordEmailScreen()),
    GetPage(name: otpVerificationScreen, page: ()=> const OtpVerificationScreen()),
    GetPage(name: changePasswordScreen, page: ()=> const ChangePasswordScreen()),
    GetPage(name: scheduleScreen, page: ()=> const ScheduleScreen()),
    GetPage(name: notificationScreen, page: ()=> const NotificationScreen()),
    GetPage(name: trainerProfileScreen, page: ()=> const TrainerProfileScreen()),
    GetPage(name: accountSettingsScreen, page: ()=> const AccountSettingsScreen()),
    GetPage(name: personalInfoScreen, page: ()=> const PersonalInfoScreen()),
    GetPage(name: notificationSettingsScreen, page: ()=> const NotificationSettingsScreen()),
    GetPage(name: profileChangePasswordScreen, page: ()=> const profile.ChangePasswordScreen()),
    GetPage(name: privacyPolicyScreen, page: ()=> const PrivacyPolicyScreen()),
    GetPage(name: termsOfServiceScreen, page: ()=> const TermsOfServiceScreen()),
    GetPage(name: aboutUsScreen, page: ()=> const AboutUsScreen()),
    GetPage(name: helpCenterScreen, page: ()=> const HelpCenterScreen()),
    GetPage(name: trainerBottomNavScreen, page: ()=> const TrainerBottomNavScreen()),
  ];
}

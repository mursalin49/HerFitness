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
    GetPage(name: trainerBottomNavScreen, page: ()=> const TrainerBottomNavScreen()),
  ];

}
import 'package:flutter/material.dart';
import 'package:fitness/Helpers/route.dart';
import 'package:get/get.dart';
import '../../../../utils/AppColor/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.welcomeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.actionPrimaryHover,
              Colors.white,
              AppColors.actionPrimaryHover,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/splashImg.png',
            width: 250,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

import 'package:fitness/Helpers/route.dart';
import 'package:fitness/core/network/api_client.dart';
import 'package:fitness/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  SignInController({AuthService? authService})
    : _authService = authService ?? AuthService();

  final AuthService _authService;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final rememberMe = false.obs;

  Future<void> signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Missing information',
        'Please enter your email and password.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;
      final authResponse = await _authService.signIn(
        username: email,
        password: password,
        rememberMe: rememberMe.value,
      );

      final role = authResponse.user?.role?.toLowerCase();
      if (role == 'trainer') {
        Get.offAllNamed(AppRoutes.trainerBottomNavScreen);
        return;
      }

      Get.offAllNamed(AppRoutes.memberBottomNavScreen);
    } on ApiException catch (error) {
      Get.snackbar(
        'Sign in failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Sign in failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

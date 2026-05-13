import 'package:fitness/Helpers/route.dart';
import 'package:fitness/core/network/api_client.dart';
import 'package:fitness/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordRecoveryController extends GetxController {
  PasswordRecoveryController({AuthService? authService})
    : _authService = authService ?? AuthService();

  final AuthService _authService;

  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final code = ''.obs;
  final isSendingCode = false.obs;
  final isVerifyingCode = false.obs;
  final isResettingPassword = false.obs;

  Future<void> sendForgotPasswordCode() async {
    final email = _emailFromArgsOrController;
    if (email.isEmpty) {
      Get.snackbar(
        'Email required',
        'Please enter your email address.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isSendingCode.value = true;
      await _authService.forgotPassword(email: email);
      Get.toNamed(
        AppRoutes.passwordVerificationScreen,
        arguments: {'flow': 'forgotPassword', 'email': email},
      );
    } on ApiException catch (error) {
      Get.snackbar(
        'Reset failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Reset failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSendingCode.value = false;
    }
  }

  Future<void> verifyEmailCode() async {
    final email = _emailFromArgsOrController;
    final currentCode = code.value.trim();

    if (email.isEmpty || currentCode.length != 6) {
      Get.snackbar(
        'Invalid code',
        'Please enter the 6-digit code sent to your email.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isVerifyingCode.value = true;
      await _authService.verifyEmail(email: email, code: currentCode);
      Get.toNamed(
        AppRoutes.changePasswordScreen,
        arguments: {'email': email, 'code': currentCode},
      );
    } on ApiException catch (error) {
      Get.snackbar(
        'Verification failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Verification failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isVerifyingCode.value = false;
    }
  }

  Future<void> resetPassword() async {
    final email = _emailFromArgsOrController;
    final currentCode = _codeFromArgsOrController;
    final newPassword = newPasswordController.text;
    final confirmNewPassword = confirmPasswordController.text;

    if (email.isEmpty || currentCode.isEmpty) {
      Get.snackbar(
        'Reset failed',
        'Email or verification code is missing.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (newPassword.isEmpty || confirmNewPassword.isEmpty) {
      Get.snackbar(
        'Password required',
        'Please enter and confirm your new password.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (newPassword != confirmNewPassword) {
      Get.snackbar(
        'Password mismatch',
        'New password and confirm password do not match.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isResettingPassword.value = true;
      await _authService.resetPassword(
        email: email,
        code: currentCode,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );
      Get.snackbar(
        'Password updated',
        'Please sign in with your new password.',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed(AppRoutes.signInScreen);
    } on ApiException catch (error) {
      Get.snackbar(
        'Reset failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Reset failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isResettingPassword.value = false;
    }
  }

  String get _emailFromArgsOrController {
    final args = Get.arguments;
    if (args is Map && args['email'] is String) {
      return args['email'] as String;
    }
    return emailController.text.trim();
  }

  String get _codeFromArgsOrController {
    final args = Get.arguments;
    if (args is Map && args['code'] is String) {
      return args['code'] as String;
    }
    return code.value.trim();
  }

  @override
  void onClose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

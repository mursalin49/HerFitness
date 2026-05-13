import 'package:fitness/core/network/api_client.dart';
import 'package:fitness/models/user_profile_model.dart';
import 'package:fitness/services/user_service.dart';
import 'package:get/get.dart';

class TrainerProfileController extends GetxController {
  TrainerProfileController({UserService? userService})
    : _userService = userService ?? UserService();

  final UserService _userService;

  final user = Rxn<UserProfileModel>();
  final isLoading = false.obs;
  final isChangingPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  String get displayName => user.value?.displayName ?? 'Trainer';

  String get displayLocation =>
      user.value?.displayLocation ?? 'Location not added';

  String get profileImageUrl => user.value?.imageUrl?.trim() ?? '';

  Future<void> fetchProfile({bool showError = false}) async {
    try {
      isLoading.value = true;
      user.value = await _userService.getCurrentUser();
    } on ApiException catch (error) {
      if (showError) {
        Get.snackbar(
          'Profile failed',
          error.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (_) {
      if (showError) {
        Get.snackbar(
          'Profile failed',
          'Could not load profile information.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      isChangingPassword.value = true;
      await _userService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );

      Get.snackbar(
        'Password updated',
        'Your password has been changed successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on ApiException catch (error) {
      Get.snackbar(
        'Password update failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Password update failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isChangingPassword.value = false;
    }

    return false;
  }
}

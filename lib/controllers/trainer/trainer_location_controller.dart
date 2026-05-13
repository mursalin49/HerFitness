import 'package:fitness/core/network/api_client.dart';
import 'package:fitness/services/location_service.dart';
import 'package:get/get.dart';

class TrainerLocationController extends GetxController {
  TrainerLocationController({LocationService? locationService})
    : _locationService = locationService ?? LocationService();

  final LocationService _locationService;

  final isOnline = false.obs;
  final isUpdating = false.obs;
  final baseLat = Rxn<double>();
  final baseLng = Rxn<double>();

  static const double defaultLat = 23.8103;
  static const double defaultLng = 90.4125;

  Future<bool> setBaseLocation({
    required double lat,
    required double lng,
  }) async {
    try {
      isUpdating.value = true;
      await _locationService.setTrainerBaseLocation(lat: lat, lng: lng);
      baseLat.value = lat;
      baseLng.value = lng;
      Get.snackbar(
        'Base location saved',
        'Your trainer base location has been updated.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on ApiException catch (error) {
      Get.snackbar(
        'Location update failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Location update failed',
        'Could not update trainer base location.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
    }

    return false;
  }

  Future<bool> updateLiveLocation({
    required double lat,
    required double lng,
    bool showSuccess = true,
  }) async {
    try {
      isUpdating.value = true;
      await _locationService.updateTrainerLiveLocation(lat: lat, lng: lng);
      if (showSuccess) {
        Get.snackbar(
          'Live location updated',
          'Members can now see your latest live location.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      return true;
    } on ApiException catch (error) {
      Get.snackbar(
        'Live location failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Live location failed',
        'Could not update trainer live location.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
    }

    return false;
  }

  Future<bool> clearLiveLocation({bool showSuccess = true}) async {
    try {
      isUpdating.value = true;
      await _locationService.clearTrainerLiveLocation();
      if (showSuccess) {
        Get.snackbar(
          'Live location cleared',
          'Your live location is no longer visible.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      return true;
    } on ApiException catch (error) {
      Get.snackbar(
        'Live location failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Live location failed',
        'Could not clear trainer live location.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
    }

    return false;
  }

  Future<void> toggleOnlineStatus(
    bool value, {
    double? lat,
    double? lng,
  }) async {
    final previousValue = isOnline.value;
    final liveLat = lat ?? baseLat.value ?? defaultLat;
    final liveLng = lng ?? baseLng.value ?? defaultLng;
    isOnline.value = value;

    try {
      isUpdating.value = true;
      await _locationService.updateTrainerOnlineStatus(isOnline: value);

      if (value) {
        await _locationService.updateTrainerLiveLocation(
          lat: liveLat,
          lng: liveLng,
        );
      } else {
        await _locationService.clearTrainerLiveLocation();
      }

      Get.snackbar(
        value ? 'You are online' : 'You are offline',
        value
            ? 'Your live location is active for nearby members.'
            : 'Your live location has been cleared.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on ApiException catch (error) {
      isOnline.value = previousValue;
      Get.snackbar(
        'Status update failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      isOnline.value = previousValue;
      Get.snackbar(
        'Status update failed',
        'Could not update trainer online status.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
    }
  }
}

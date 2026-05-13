import 'package:fitness/core/network/api_client.dart';
import 'package:fitness/services/location_service.dart';
import 'package:get/get.dart';

class TrainerListController extends GetxController {
  TrainerListController({LocationService? locationService})
    : _locationService = locationService ?? LocationService();

  final LocationService _locationService;

  var selectedTab = "Near You".obs;
  var searchQuery = "".obs;
  final nearbyTrainers = <Map<String, dynamic>>[].obs;
  final searchResults = <Map<String, dynamic>>[].obs;
  final isLoadingNearby = false.obs;
  final isLoadingSearch = false.obs;

  static const double defaultLat = 23.8103;
  static const double defaultLng = 90.4125;
  Worker? _searchWorker;

  @override
  void onInit() {
    super.onInit();
    fetchNearbyTrainers();
    _searchWorker = debounce<String>(
      searchQuery,
      (_) => searchTrainers(),
      time: const Duration(milliseconds: 450),
    );
  }

  void setTab(String tab) {
    selectedTab.value = tab;
    if (tab == "Near You" && nearbyTrainers.isEmpty) {
      fetchNearbyTrainers();
    }
  }

  void onSearch(String query) {
    searchQuery.value = query;
  }

  Future<void> fetchNearbyTrainers({
    double lat = defaultLat,
    double lng = defaultLng,
    double radiusKm = 10,
    bool showError = false,
  }) async {
    try {
      isLoadingNearby.value = true;
      try {
        await _locationService.saveMemberLocation(lat: lat, lng: lng);
      } catch (_) {
        // Nearby search can still work even when saving current location fails.
      }
      final response = await _locationService.findNearbyTrainers(
        lat: lat,
        lng: lng,
        radiusKm: radiusKm,
      );
      nearbyTrainers.assignAll(response.map((item) => item.toUiMap()));
    } on ApiException catch (error) {
      if (showError) {
        Get.snackbar(
          'Nearby trainers failed',
          error.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (_) {
      if (showError) {
        Get.snackbar(
          'Nearby trainers failed',
          'Could not load nearby trainers.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoadingNearby.value = false;
    }
  }

  Future<void> searchTrainers({bool showError = false}) async {
    final query = searchQuery.value.trim();
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isLoadingSearch.value = true;
      final response = await _locationService.searchTrainers(name: query);
      searchResults.assignAll(response.map((item) => item.toUiMap()));
    } on ApiException catch (error) {
      if (showError) {
        Get.snackbar(
          'Trainer search failed',
          error.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (_) {
      if (showError) {
        Get.snackbar(
          'Trainer search failed',
          'Could not search trainers.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoadingSearch.value = false;
    }
  }

  Map<String, dynamic> trainerArgs(Map<String, dynamic> trainer) {
    return {
      'trainerId': trainer['id'],
      'trainer': trainer,
      'lat': defaultLat,
      'lng': defaultLng,
    };
  }

  @override
  void onClose() {
    _searchWorker?.dispose();
    super.onClose();
  }
}

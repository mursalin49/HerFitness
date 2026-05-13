import 'package:fitness/core/network/api_client.dart';
import 'package:fitness/services/location_service.dart';
import 'package:get/get.dart';

class TrainerDetailsController extends GetxController {
  TrainerDetailsController({LocationService? locationService})
    : _locationService = locationService ?? LocationService();

  final LocationService _locationService;

  var selectedTimeSlot = "10:00 AM".obs;
  final trainer = Rxn<Map<String, dynamic>>();
  final isLoading = false.obs;

  final List<String> timeSlots = [
    "10:00 AM",
    "11:00 AM",
    "12:00 AM",
    "01:00 PM",
  ];

  void selectTimeSlot(String time) {
    selectedTimeSlot.value = time;
  }

  @override
  void onInit() {
    super.onInit();
    _loadInitialTrainer();
    fetchTrainerProfile();
  }

  Future<void> fetchTrainerProfile({bool showError = false}) async {
    final id = trainer.value?['id']?.toString();
    if (id == null || id.isEmpty) return;

    try {
      isLoading.value = true;
      final args = Get.arguments;
      final lat = args is Map && args['lat'] is num
          ? (args['lat'] as num).toDouble()
          : null;
      final lng = args is Map && args['lng'] is num
          ? (args['lng'] as num).toDouble()
          : null;
      final response = await _locationService.getTrainerProfile(
        id: id,
        lat: lat,
        lng: lng,
      );
      trainer.value = response.toUiMap();
    } on ApiException catch (error) {
      if (showError) {
        Get.snackbar(
          'Trainer profile failed',
          error.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (_) {
      if (showError) {
        Get.snackbar(
          'Trainer profile failed',
          'Could not load trainer profile.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _loadInitialTrainer() {
    final args = Get.arguments;
    if (args is Map && args['trainer'] is Map) {
      final trainerMap = args['trainer'] as Map;
      trainer.value = trainerMap.map(
        (key, value) => MapEntry(key.toString(), value),
      );
      return;
    }

    if (args is Map && args['trainerId'] != null) {
      trainer.value = {'id': args['trainerId'].toString()};
    }
  }
}

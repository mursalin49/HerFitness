import 'package:fitness/core/network/api_client.dart';
import 'package:fitness/models/trainer_class_model.dart';
import 'package:fitness/services/trainer_class_service.dart';
import 'package:get/get.dart';

class MyClassesController extends GetxController {
  MyClassesController({TrainerClassService? trainerClassService})
    : _trainerClassService = trainerClassService ?? TrainerClassService();

  final TrainerClassService _trainerClassService;

  final RxList<Map<String, dynamic>> classes = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchClasses();
  }

  Future<void> fetchClasses({bool showError = false}) async {
    try {
      isLoading.value = true;
      final response = await _trainerClassService.getClasses();
      classes.assignAll(response.map((item) => item.toUiMap()));
    } on ApiException catch (error) {
      if (showError) {
        Get.snackbar(
          'Classes failed',
          error.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (_) {
      if (showError) {
        Get.snackbar(
          'Classes failed',
          'Could not load classes.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addClass(TrainerClassPayload payload) async {
    try {
      isSaving.value = true;
      final createdClass = await _trainerClassService.createClass(payload);
      if (createdClass == null) {
        await fetchClasses();
      } else {
        classes.add(createdClass.toUiMap());
      }
      Get.snackbar(
        'Class created',
        'Your class has been published.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on ApiException catch (error) {
      Get.snackbar(
        'Create failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Create failed',
        'Could not create class.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSaving.value = false;
    }

    return false;
  }

  Future<bool> updateClass(int index, TrainerClassPayload payload) async {
    if (index < 0 || index >= classes.length) return false;

    final id = classes[index]['id']?.toString();
    if (id == null || id.isEmpty) {
      Get.snackbar(
        'Update failed',
        'Class ID was not found.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    try {
      isSaving.value = true;
      final updatedClass = await _trainerClassService.updateClass(
        id: id,
        payload: payload,
      );
      if (updatedClass == null) {
        await fetchClasses();
      } else {
        classes[index] = updatedClass.toUiMap();
      }
      Get.snackbar(
        'Class updated',
        'Your changes have been saved.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on ApiException catch (error) {
      Get.snackbar(
        'Update failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Update failed',
        'Could not update class.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSaving.value = false;
    }

    return false;
  }

  Future<bool> deleteClass(int index) async {
    if (index < 0 || index >= classes.length) return false;

    final id = classes[index]['id']?.toString();
    if (id == null || id.isEmpty) {
      Get.snackbar(
        'Delete failed',
        'Class ID was not found.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    try {
      isSaving.value = true;
      await _trainerClassService.deleteClass(id);
      classes.removeAt(index);
      Get.snackbar(
        'Class deleted',
        'The class has been cancelled.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on ApiException catch (error) {
      Get.snackbar(
        'Delete failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Delete failed',
        'Could not delete class.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSaving.value = false;
    }

    return false;
  }
}

import 'package:fitness/core/network/api_client.dart';
import 'package:fitness/models/trainer_class_model.dart';
import 'package:fitness/services/trainer_class_service.dart';
import 'package:get/get.dart';
import 'package:fitness/utils/app_snackbar.dart';

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
        showAppSnackbar(
          'Classes failed',
          error.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (_) {
      if (showError) {
        showAppSnackbar(
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
      showAppSnackbar(
        'Class created',
        'Your class has been published.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on ApiException catch (error) {
      showAppSnackbar(
        'Create failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      showAppSnackbar(
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
      showAppSnackbar(
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
      showAppSnackbar(
        'Class updated',
        'Your changes have been saved.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on ApiException catch (error) {
      showAppSnackbar(
        'Update failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      showAppSnackbar(
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
      showAppSnackbar(
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
      showAppSnackbar(
        'Class deleted',
        'The class has been cancelled.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on ApiException catch (error) {
      showAppSnackbar(
        'Delete failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      showAppSnackbar(
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

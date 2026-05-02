import 'package:get/get.dart';

class AssessmentController extends GetxController {
  // Goal selection
  var selectedGoalIndex = (-1).obs;

  // Weight selection
  var weight = 128.0.obs;
  var weightUnit = 'kg'.obs; // 'kg' or 'lbs'

  // Age selection
  var age = 18.obs;

  // Fitness experience
  var hasExperience = false.obs;

  // Physical limitations
  var limitations = <String>[].obs;

  // Diet preference
  var selectedDietIndex = (-1).obs;

  // Supplements
  var takingSupplements = false.obs;
  var selectedSupplements = <String>[].obs;

  // Calorie goal
  var calorieGoal = 1550.obs;
  var calorieUnit = 'Kcal'.obs; // 'Kcal' or 'Joule's'

  // Sleep quality
  var selectedSleepIndex = (-1).obs;

  void setGoal(int index) {
    selectedGoalIndex.value = index;
  }

  void setWeight(double value) {
    weight.value = value;
  }

  void setWeightUnit(String unit) {
    weightUnit.value = unit;
  }

  void setAge(int value) {
    age.value = value;
  }

  void setExperience(bool value) {
    hasExperience.value = value;
  }

  void addLimitation(String value) {
    if (limitations.length < 10 && value.isNotEmpty && !limitations.contains(value)) {
      limitations.add(value);
    }
  }

  void removeLimitation(String value) {
    limitations.remove(value);
  }

  void setDietPreference(int index) {
    selectedDietIndex.value = index;
  }

  void setTakingSupplements(bool value) {
    takingSupplements.value = value;
  }

  void toggleSupplement(String supplement) {
    if (selectedSupplements.contains(supplement)) {
      selectedSupplements.remove(supplement);
    } else {
      selectedSupplements.add(supplement);
    }
  }

  void setCalorieGoal(int value) {
    calorieGoal.value = value;
  }

  void setCalorieUnit(String unit) {
    calorieUnit.value = unit;
  }

  void setSleepQuality(int index) {
    selectedSleepIndex.value = index;
  }
}

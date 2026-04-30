import 'package:get/get.dart';

class AssessmentController extends GetxController {
  // Goal selection
  var selectedGoalIndex = (-1).obs;

  // Weight selection
  var weight = 128.0.obs;
  var weightUnit = 'kg'.obs; // 'kg' or 'lbs'

  // Age selection
  var age = 18.obs;

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
}

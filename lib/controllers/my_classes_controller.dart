import 'package:get/get.dart';

class MyClassesController extends GetxController {
  // Observable list of classes
  final RxList<Map<String, dynamic>> classes = <Map<String, dynamic>>[
    {
      "title": "Back Workout",
      "time": "05:30 PM",
      "duration": 45,
      "price": 22.0,
      "maxMembers": 12,
      "classType": "Online",
      "sessionFormat": "One-to-one"
    },
    {
      "title": "Back Workout",
      "time": "05:30 PM",
      "duration": 60,
      "price": 22.0,
      "maxMembers": 12,
      "classType": "In person",
      "sessionFormat": "Group"
    },
    {
      "title": "Back Workout",
      "time": "05:30 PM",
      "duration": 60,
      "price": 22.0,
      "maxMembers": 12,
      "classType": "Online",
      "sessionFormat": "Group"
    },
  ].obs;

  void addClass(Map<String, dynamic> newClass) {
    classes.add(newClass);
  }

  void updateClass(int index, Map<String, dynamic> updatedClass) {
    if (index >= 0 && index < classes.length) {
      classes[index] = updatedClass;
    }
  }

  void deleteClass(int index) {
    if (index >= 0 && index < classes.length) {
      classes.removeAt(index);
    }
  }
}

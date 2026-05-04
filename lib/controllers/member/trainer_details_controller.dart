import 'package:get/get.dart';

class TrainerDetailsController extends GetxController {
  var selectedTimeSlot = "10:00 AM".obs;

  final List<String> timeSlots = [
    "10:00 AM",
    "11:00 AM",
    "12:00 AM",
    "01:00 PM",
  ];

  void selectTimeSlot(String time) {
    selectedTimeSlot.value = time;
  }
}

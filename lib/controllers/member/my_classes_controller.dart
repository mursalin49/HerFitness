import 'package:get/get.dart';

class MyClassesController extends GetxController {
  var selectedFilter = "All".obs;
  
  var selectedRescheduleDate = "mm/dd/yyyy".obs;
  var selectedRescheduleTime = "07:00 AM".obs;
  
  final List<String> filters = ["All", "Meditation", "Yoga", "Cardio", "Strength"];

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  // Sample data for classes
  final List<Map<String, dynamic>> allSchedules = [
    {
      "title": "Back Workout",
      "trainer": "Seraphina Dubois",
      "date": "Today",
      "time": "07:00 AM",
      "status": "Completed",
      "category": "Strength"
    },
    {
      "title": "Back Workout",
      "trainer": "Seraphina Dubois",
      "date": "Today",
      "time": "07:00 AM",
      "status": "Pending", // Showing "Check In" and "Rescheduled"
      "category": "Strength"
    },
    {
      "title": "Back Workout",
      "trainer": "John Franklin",
      "date": "April 20, 2026",
      "time": "07:00 AM",
      "status": "Upcoming", // Showing "Cancel" and "Rescheduled"
      "category": "Strength"
    },
  ];

  List<Map<String, dynamic>> get filteredSchedules {
    if (selectedFilter.value == "All") return allSchedules;
    return allSchedules.where((s) => s["category"] == selectedFilter.value).toList();
  }

  void updateRescheduleDate(String date) {
    selectedRescheduleDate.value = date;
  }

  void updateRescheduleTime(String time) {
    selectedRescheduleTime.value = time;
  }
}

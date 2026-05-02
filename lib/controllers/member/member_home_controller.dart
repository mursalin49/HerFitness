import 'package:get/get.dart';

class MemberHomeController extends GetxController {
  var selectedCategory = "All".obs;
  
  final List<String> categories = ["All", "Nearby", "Yoga", "Pilates", "Strength", "Cardio"];

  var nextWorkouts = [
    {
      "title": "Yoga Flow",
      "subtitle": "5 Series Workout",
      "date": "10-04-2026",
      "duration": "30min",
      "image": "assets/images/yoga_flow.png" // Placeholder, should be replaced with real assets or generated images
    }
  ].obs;

  var trainers = [
    {
      "name": "Seraphina Dubois",
      "expertise": "Yoga & Pilates",
      "rating": 4.5,
      "price": "85/hr",
      "image": "assets/images/trainer_1.png"
    },
    {
      "name": "Seraphina Dubois",
      "expertise": "Yoga & Pilates",
      "rating": 4.5,
      "price": "85/hr",
      "image": "assets/images/trainer_1.png"
    }
  ].obs;

  void setCategory(String category) {
    selectedCategory.value = category;
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
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
      "image": "assets/images/yoga_flow.png"
    }
  ].obs;

  var trainers = [
    {
      "name": "Seraphina Dubois",
      "expertise": "Yoga & Pilates",
      "rating": 4.5,
      "price": "100/session",
      "image": "assets/images/trainer_1.png",
      "location": "500m"
    },
    {
      "name": "Seraphina Dubois",
      "expertise": "Yoga & Pilates",
      "rating": 4.5,
      "price": "150/session",
      "image": "assets/images/trainer_1.png",
      "location": "800m"
    }
  ].obs;

  // Banner Logic
  final PageController bannerPageController = PageController(initialPage: 1000);
  var bannerIndex = 1000.obs;
  final List<Map<String, String>> banners = [
    {
      "title": "New features or\nevents in the gym",
      "image": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=600&auto=format&fit=crop"
    },
    {
      "title": "Join our Yoga\nWeekend Retreat",
      "image": "https://bookretreats.com/cdn-cgi/image/width=1200,quality=65,f=auto,sharpen=1,fit=cover,gravity=auto/assets/photo/retreat/0m/34k/34873/p_1148701/1000_1692669332.jpg"
    },
    {
      "title": "Limited Time: 20%\nOff Annual Pass",
      "image": "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=600&auto=format&fit=crop"
    },
    {
      "title": "Free Personal\nTraining Session",
      "image": "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?q=80&w=600&auto=format&fit=crop"
    },
    {
      "title": "Unlock Your Potential\nwith Our Trainers",
      "image": "https://images.unsplash.com/photo-1593079831268-3381b0db4a77?q=80&w=600&auto=format&fit=crop"
    },
  ];

  Timer? _bannerTimer;

  @override
  void onInit() {
    super.onInit();
    _startBannerTimer();
  }

  void _startBannerTimer() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      bannerIndex.value++;
      if (bannerPageController.hasClients) {
        bannerPageController.animateToPage(
          bannerIndex.value,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void onClose() {
    _bannerTimer?.cancel();
    bannerPageController.dispose();
    super.onClose();
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }
}

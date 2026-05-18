import 'dart:async';
import 'package:fitness/core/network/api_client.dart';
import 'package:fitness/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness/utils/app_snackbar.dart';

class MemberHomeController extends GetxController {
  MemberHomeController({LocationService? locationService})
    : _locationService = locationService ?? LocationService();

  final LocationService _locationService;

  var selectedCategory = "All".obs;

  final List<String> categories = [
    "All",
    "Nearby",
    "Yoga",
    "Pilates",
    "Strength",
    "Cardio",
  ];

  var nextWorkouts = [
    {
      "title": "Yoga Flow",
      "subtitle": "5 Series Workout",
      "date": "10-04-2026",
      "duration": "30min",
      "image": "assets/images/yoga_flow.png",
    },
  ].obs;

  final trainers = <Map<String, dynamic>>[].obs;
  final isLoadingTrainers = false.obs;

  static const double defaultLat = 23.8103;
  static const double defaultLng = 90.4125;

  // Banner Logic
  final PageController bannerPageController = PageController(initialPage: 1000);
  var bannerIndex = 1000.obs;
  final List<Map<String, String>> banners = [
    {
      "title": "New features or\nevents in the gym",
      "image":
          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=600&auto=format&fit=crop",
    },
    {
      "title": "Join our Yoga\nWeekend Retreat",
      "image":
          "https://bookretreats.com/cdn-cgi/image/width=1200,quality=65,f=auto,sharpen=1,fit=cover,gravity=auto/assets/photo/retreat/0m/34k/34873/p_1148701/1000_1692669332.jpg",
    },
    {
      "title": "Limited Time: 20%\nOff Annual Pass",
      "image":
          "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=600&auto=format&fit=crop",
    },
    {
      "title": "Free Personal\nTraining Session",
      "image":
          "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?q=80&w=600&auto=format&fit=crop",
    },
    {
      "title": "Unlock Your Potential\nwith Our Trainers",
      "image":
          "https://images.unsplash.com/photo-1593079831268-3381b0db4a77?q=80&w=600&auto=format&fit=crop",
    },
  ];

  Timer? _bannerTimer;

  @override
  void onInit() {
    super.onInit();
    _startBannerTimer();
    fetchAllTrainers();
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

  String get trainerSectionTitle {
    final category = selectedCategory.value;
    if (category == "All") {
      return "All Trainers";
    }
    if (category == "Nearby") {
      return "Nearby Trainer";
    }
    return "$category Trainer";
  }

  String get emptyTrainerMessage {
    final category = selectedCategory.value;
    if (category == "All") {
      return "No trainers found.";
    }
    if (category == "Nearby") {
      return "No nearby trainers found.";
    }
    return "No $category trainers found.";
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    if (category == "All") {
      fetchAllTrainers(showError: true);
      return;
    }

    if (category == "Nearby") {
      fetchNearbyTrainers(showError: true);
      return;
    }

    fetchTrainersBySpecialty(category, showError: true);
  }

  Future<void> fetchAllTrainers({bool showError = false}) async {
    try {
      isLoadingTrainers.value = true;
      final response = await _locationService.searchTrainers();
      trainers.assignAll(response.map((item) => item.toUiMap()));
    } on ApiException catch (error) {
      if (showError) {
        showAppSnackbar(
          'Trainers failed',
          error.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (_) {
      if (showError) {
        showAppSnackbar(
          'Trainers failed',
          'Could not load trainers.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoadingTrainers.value = false;
    }
  }

  Future<void> fetchNearbyTrainers({
    double lat = defaultLat,
    double lng = defaultLng,
    double radiusKm = 10,
    bool showError = false,
  }) async {
    try {
      isLoadingTrainers.value = true;
      try {
        await _locationService.saveMemberLocation(lat: lat, lng: lng);
      } catch (_) {
        // Home can still show nearby trainers if saving location is rejected.
      }
      final response = await _locationService.findNearbyTrainers(
        lat: lat,
        lng: lng,
        radiusKm: radiusKm,
      );
      trainers.assignAll(response.map((item) => item.toUiMap()));
    } on ApiException catch (error) {
      if (showError) {
        showAppSnackbar(
          'Nearby trainers failed',
          error.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (_) {
      if (showError) {
        showAppSnackbar(
          'Nearby trainers failed',
          'Could not load nearby trainers.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoadingTrainers.value = false;
    }
  }

  Future<void> fetchTrainersBySpecialty(
    String specialty, {
    bool showError = false,
  }) async {
    try {
      isLoadingTrainers.value = true;
      final response = await _locationService.searchTrainers(
        specialty: specialty,
      );
      trainers.assignAll(response.map((item) => item.toUiMap()));
    } on ApiException catch (error) {
      if (showError) {
        showAppSnackbar(
          'Trainer search failed',
          error.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (_) {
      if (showError) {
        showAppSnackbar(
          'Trainer search failed',
          'Could not load $specialty trainers.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoadingTrainers.value = false;
    }
  }

  Map<String, dynamic> trainerArgs(Map<String, dynamic> trainer) {
    return {
      'trainerId': trainer['id'],
      'trainer': trainer,
      'lat': defaultLat,
      'lng': defaultLng,
    };
  }
}

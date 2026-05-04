import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookTrainerController extends GetxController {
  // Navigation
  var currentStep = 1.obs;

  // Step 1: Personal Info
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final commentController = TextEditingController();

  // Step 2: Date & Time
  var selectedDate = DateTime.now().obs;
  var focusedDate = DateTime.now().obs;
  var selectedTime = "06:15".obs;
  var isReminderEnabled = true.obs;
  var selectedPeriod = "PM".obs; // AM or PM

  final List<String> availableSlots = ["03:00", "06:15", "09:00", "10:30", "13:30", "15:45"];

  // Step 3: Payment
  var selectedPaymentMethod = "Credit Card".obs;
  final couponController = TextEditingController();

  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
    } else {
      // Proceed to success
      Get.snackbar("Success", "Booking and Payment Successful!");
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    } else {
      Get.back();
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    commentController.dispose();
    couponController.dispose();

    super.onClose();
  }
}

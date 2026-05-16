import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookTrainerController extends GetxController {
  final currentStep = 1.obs;

  final fullNameController = TextEditingController(text: 'Jane Cooper');
  final emailController = TextEditingController(
    text: 'danghoang87hl@gmail.com',
  );
  final phoneController = TextEditingController(text: '(907) 555-0101');
  final locationController = TextEditingController(
    text: 'Syracuse, Connecticut',
  );
  final commentController = TextEditingController(text: '18 y');

  final selectedClassType = 'Single session'.obs;
  final selectedDate = DateTime(2026, 6, 7).obs;
  final focusedDate = DateTime(2026, 6, 1).obs;
  final selectedTime = '06:15'.obs;
  final selectedSlotIndex = 1.obs;
  final selectedPeriod = 'PM'.obs;
  final isReminderEnabled = true.obs;
  final selectedSessionIndex = 0.obs;

  final selectedPaymentMethod = 'Stripe'.obs;
  final couponController = TextEditingController(text: 'Firsttime20');
  final cardHolderController = TextEditingController(text: 'Dubois');
  final cardNumberController = TextEditingController(
    text: '4242-4242-4242-4242',
  );
  final expController = TextEditingController(text: '01/26');
  final cvcController = TextEditingController(text: '752');

  late final Map<String, dynamic> trainer = _trainerFromArgs();

  final List<String> classTypes = const ['Monthly session', 'Single session'];
  final List<String> availableSlots = const [
    '03:00',
    '06:15',
    '03:00',
    '03:00',
    '06:15',
    '06:15',
    '06:15',
    '06:15',
    '13:30',
    '13:30',
    '13:30',
    '13:30',
  ];

  final List<Map<String, dynamic>> sessions = const [
    {
      'title': 'Back Workout',
      'date': 'April 20, 2026',
      'time': '06:15 PM',
      'location': 'Abcd Road 1200',
      'classType': 'in person',
      'format': 'One-to-One',
      'price': 22.0,
    },
    {
      'title': 'Back Workout',
      'date': 'April 20, 2026',
      'time': '06:15 PM',
      'location': 'Abcd Road 1200',
      'classType': 'in person',
      'format': 'One-to-One',
      'price': 22.0,
    },
  ];

  String get trainerName => _readTrainerString('name', 'Seraphina Dubois');

  String get trainerImageUrl => _readTrainerString(
    'imageUrl',
    'https://as1.ftcdn.net/jpg/02/26/49/16/1000_F_226491635_4Qp2RzkMlglsfSLIzXjLeRmqdTnaD4p8.jpg',
  );

  double get trainerRating {
    final value = trainer['rating'];
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 4.5;
  }

  int get reviewCount {
    final value = trainer['reviewCount'];
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 21;
  }

  String get displayDate =>
      DateFormat('MMMM dd, yyyy').format(selectedDate.value);

  String get summaryDate =>
      DateFormat('MMMM dd, yyyy').format(selectedDate.value);

  String get summaryTime => '${selectedTime.value} ${selectedPeriod.value}';

  double get trainingPrice => 25.00;

  double get discount => 2.50;

  double get tax => 0.63;

  double get total => 85.52;

  String priceText(double value) => '\$${value.toStringAsFixed(2)}';

  void nextStep() {
    if (currentStep.value < 5) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
      return;
    }
    Get.back();
  }

  void setClassType(String value) {
    selectedClassType.value = value;
  }

  void setSessionIndex(int index) {
    selectedSessionIndex.value = index;
  }

  void setTimeSlot(int index) {
    selectedSlotIndex.value = index;
    selectedTime.value = availableSlots[index];
  }

  void setPaymentMethod(String value) {
    selectedPaymentMethod.value = value;
  }

  Map<String, dynamic> _trainerFromArgs() {
    final args = Get.arguments;
    if (args is Map && args['trainer'] is Map) {
      return (args['trainer'] as Map).map(
        (key, value) => MapEntry(key.toString(), value),
      );
    }
    return const <String, dynamic>{};
  }

  String _readTrainerString(String key, String fallback) {
    final value = trainer[key]?.toString().trim();
    if (value != null && value.isNotEmpty) return value;
    return fallback;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    commentController.dispose();
    couponController.dispose();
    cardHolderController.dispose();
    cardNumberController.dispose();
    expController.dispose();
    cvcController.dispose();
    super.onClose();
  }
}

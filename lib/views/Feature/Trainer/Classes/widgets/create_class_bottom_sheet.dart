import 'package:fitness/controllers/my_classes_controller.dart';
import 'package:fitness/utils/AppColor/app_colors.dart';
import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:fitness/views/Base/AppButton/appButton.dart';
import 'package:fitness/views/Base/AppText/appText.dart';
import 'package:fitness/views/Base/CustomTextfield/CustomTextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateClassBottomSheet extends StatefulWidget {
  const CreateClassBottomSheet({super.key});

  @override
  State<CreateClassBottomSheet> createState() => _CreateClassBottomSheetState();
}

class _CreateClassBottomSheetState extends State<CreateClassBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final MyClassesController controller = Get.find<MyClassesController>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();

  DateTime? _selectedDateTime;
  String? _selectedType;
  String? _selectedFormat;

  final List<String> _classTypes = ["Online", "In Person"];
  final List<String> _sessionFormats = ["One-to-one", "Group"];

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: AppColors.actionPrimary),
          textTheme: Theme.of(context).textTheme.copyWith(
            // Controls the large "Mon, Apr 27" headline in date picker header
            headlineMedium: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
            ),
            headlineSmall: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.actionPrimary,
            primaryContainer: AppColors.actionPrimary,
            onPrimaryContainer: Colors.white,
            secondary: AppColors.actionPrimary,
            secondaryContainer: AppColors.actionPrimary,
            onSecondaryContainer: Colors.white,
            surface: Colors.white,
          ),
          textTheme: Theme.of(context).textTheme.copyWith(
            // Controls large hour / minute digits on the clock face
            displayLarge: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w600,
              letterSpacing: -1,
            ),
            // Controls smaller minute scroll numbers
            bodyLarge: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            bodyMedium: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (pickedTime == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        pickedDate.year, pickedDate.month, pickedDate.day,
        pickedTime.hour, pickedTime.minute,
      );
    });
  }

  bool get _isGroupFormat => _selectedFormat == "Group";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 8.h),
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          "Create New Class",
                          style: AppTextStyles.base16Medium.copyWith(color: AppColors.textPrimary),
                        ),

                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFF9F9F9),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.actionPrimary,
                                  blurRadius: 0,
                                  offset: const Offset(0, 3),
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(Icons.close, size: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Class Name
                    _FieldLabel("Class Name"),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: _nameController,
                      hintText: "E.g. morning Hit",
                      filColor: Colors.white,
                    ),
                    SizedBox(height: 20.h),

                    // Date & Time
                    _FieldLabel("Date & Time"),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: _pickDateTime,
                      child: Container(
                        height: 52.h,
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              _selectedDateTime != null
                                  ? DateFormat("d MMM yyyy  hh:mm a").format(_selectedDateTime!)
                                  : "Pick a date & time",
                              style: AppTextStyles.base16Regular.copyWith(
                                color: _selectedDateTime != null
                                    ? AppColors.textPrimary
                                    : const Color(0xFF454F5B),
                              ),
                            ),
                            Icon(Icons.calendar_month_outlined, size: 20, color: Colors.grey.shade500),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Type + Duration row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FieldLabel("Type"),
                              SizedBox(height: 8.h),
                              _DropdownField(
                                hint: "Select type",
                                value: _selectedType,
                                items: _classTypes,
                                onChanged: (v) => setState(() => _selectedType = v),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FieldLabel("Duration (min)"),
                              SizedBox(height: 8.h),
                              CustomTextField(
                                controller: _durationController,
                                hintText: "00",
                                keyboardType: TextInputType.number,
                                filColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Per Member price
                    _FieldLabel("Per Member (\$)"),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: _priceController,
                      hintText: "00",
                      keyboardType: TextInputType.number,
                      filColor: Colors.white,
                    ),
                    SizedBox(height: 16.h),

                    // Session Format
                    _FieldLabel("Session Format"),
                    SizedBox(height: 8.h),
                    _DropdownField(
                      hint: "Choose format",
                      value: _selectedFormat,
                      items: _sessionFormats,
                      onChanged: (v) => setState(() {
                        _selectedFormat = v;
                        // Reset capacity if switching away from group
                        if (!_isGroupFormat) _capacityController.clear();
                      }),
                    ),
                    SizedBox(height: 16.h),

                    // Capacity — only required for Group
                    if (_isGroupFormat) ...[
                      _FieldLabel("Capacity"),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _capacityController,
                        hintText: "Enter capacity",
                        keyboardType: TextInputType.number,
                        filColor: Colors.white,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Capacity is required for Group";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                    ],

                    // Publish button
                    AppButton(
                      text: "Publish Class",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final newClass = {
                            "title": _nameController.text,
                            "time": _selectedDateTime != null 
                                ? DateFormat("hh:mm a").format(_selectedDateTime!) 
                                : "N/A",
                            "duration": int.tryParse(_durationController.text) ?? 0,
                            "price": double.tryParse(_priceController.text) ?? 0.0,
                            "maxMembers": int.tryParse(_capacityController.text) ?? 0,
                            "classType": _selectedType ?? "N/A",
                            "sessionFormat": _selectedFormat ?? "N/A"
                          };
                          controller.addClass(newClass);
                          Navigator.pop(context);
                        }
                      },
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.030)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shared helpers ───────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.sm14Medium.copyWith(color: AppColors.textPrimary),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownField({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          hint: Text(
            hint,
            style: const TextStyle(color: Color(0xFF454F5B), fontSize: 15, fontWeight: FontWeight.w400),
          ),
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade600),
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: 'WorkSans',
          ),
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}



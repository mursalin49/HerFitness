import 'package:fitness/controllers/my_classes_controller.dart';
import 'package:fitness/utils/AppColor/app_colors.dart';
import 'package:fitness/utils/AppTextStyle/app_text_styles.dart';
import 'package:fitness/views/Base/AppText/appText.dart';
import 'package:fitness/views/Feature/Trainer/Classes/widgets/class_card.dart';
import 'package:fitness/views/Feature/Trainer/Classes/widgets/create_class_bottom_sheet.dart';
import 'package:fitness/views/Feature/Trainer/Classes/widgets/delete_class_dialog.dart';
import 'package:fitness/views/Feature/Trainer/Classes/widgets/edit_class_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyClassesScreen extends StatelessWidget {
  MyClassesScreen({super.key});

  final MyClassesController controller = Get.put(MyClassesController());

  void _openCreateSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CreateClassBottomSheet(),
    );
  }

  void _openEditSheet(BuildContext context, int index, Map<String, dynamic> cls) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditClassBottomSheet(
        index: index,
        initialName: cls["title"],
        initialTime: cls["time"],
        initialDuration: cls["duration"],
        initialPrice: cls["price"],
        initialMaxMembers: cls["maxMembers"],
        initialClassType: cls["classType"],
        initialSessionFormat: cls["sessionFormat"],
      ),
    );
  }

  void _openDeleteDialog(BuildContext context, int index) async {
    final confirmed = await showDeleteClassDialog(context);
    if (confirmed == true) {
      controller.deleteClass(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                  itemCount: controller.classes.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: AppText(
                          "All Schedules",
                          style: AppTextStyles.base16SemiBold.copyWith(color: AppColors.textPrimary),
                        ),
                      );
                    }
                    final classIndex = index - 1;
                    final cls = controller.classes[classIndex];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: ClassCard(
                        className: cls["title"],
                        time: cls["time"],
                        durationMin: cls["duration"],
                        pricePerMember: cls["price"],
                        maxMembers: cls["maxMembers"],
                        classType: cls["classType"],
                        sessionFormat: cls["sessionFormat"],
                        onEdit: () => _openEditSheet(context, classIndex, cls),
                        onDelete: () => _openDeleteDialog(context, classIndex),
                      ),
                    );
                  },
                )),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.h,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.actionPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 48.w,
                height: 48.w,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: const Center(child: Icon(Icons.arrow_back_ios_new, size: 20)),
              ),
            ),
            AppText(
              "My Classes",
              style: AppTextStyles.xl20Medium.copyWith(color: Colors.white),
            ),
            GestureDetector(
              onTap: () => _openCreateSheet(context),
              child: Container(
                width: 48.w,
                height: 48.w,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: const Center(child: Icon(Icons.add, size: 28, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

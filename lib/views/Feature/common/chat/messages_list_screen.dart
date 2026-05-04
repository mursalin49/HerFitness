import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/AppColor/app_colors.dart';
import '../../../../utils/AppTextStyle/app_text_styles.dart';
import '../../../Base/CustomAppbar/custom_appbar.dart';
import '../../../Base/CustomTextfield/CustomTextfield.dart';
import '../../../../controllers/common/chat_controller.dart';
import 'chat_screen.dart';

class MessagesListScreen extends StatelessWidget {
  const MessagesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Gradient (to match other screens)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(1.0, -1.0),
                radius: 2.5,
                colors: [
                  const Color(0xFFFFA6B4).withValues(alpha: 0.5),
                  const Color(0xFFFFE0B9).withValues(alpha: 0.25),
                  Colors.white,
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const CustomAppbar(title: "Messages"),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextField(
                    controller: controller.searchController,
                    hintText: "Search Messages...",
                    suffixIcon: Icon(Icons.search, color: AppColors.textPrimary, size: 24.sp),
                    filColor: Colors.white,
                    borderColor: AppColors.borderSecondary,
                  ),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      padding: EdgeInsets.only(top: 8.h, left: 20.w, right: 20.w, bottom: 40.h),
                      itemCount: controller.contacts.length,
                      itemBuilder: (context, index) {
                        final contact = controller.contacts[index];
                        return _buildContactItem(contact);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(ChatContact contact) {
    return GestureDetector(
      onTap: () => Get.to(() => ChatScreen(contact: contact)),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFDEDEDE),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(Icons.person, color: Colors.grey[600]),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.name, style: AppTextStyles.base16Medium.copyWith(color: AppColors.textPrimary)),
                  SizedBox(height: 4.h),
                  Text(contact.lastMessage, style: AppTextStyles.sm14Regular.copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),
            if (contact.unreadCount > 0)
              Container(
                width: 24.w,
                height: 24.w,
                decoration: const BoxDecoration(
                  color: AppColors.actionPrimary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    contact.unreadCount.toString(),
                    style: AppTextStyles.sm14Regular.copyWith(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

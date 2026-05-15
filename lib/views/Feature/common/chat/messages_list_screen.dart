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
    final ChatController controller = Get.isRegistered<ChatController>()
        ? Get.find<ChatController>()
        : Get.put(ChatController());

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
                    suffixIcon: Icon(
                      Icons.search,
                      color: AppColors.textPrimary,
                      size: 24.sp,
                    ),
                    filColor: Colors.white,
                    borderColor: AppColors.borderSecondary,
                  ),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: Obx(() {
                    final contacts = controller.filteredContacts;
                    if (controller.isLoadingConversations.value &&
                        contacts.isEmpty) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.actionPrimary,
                        ),
                      );
                    }

                    if (contacts.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: () =>
                            controller.fetchConversations(showError: true),
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          children: [
                            SizedBox(height: 120.h),
                            Icon(
                              Icons.chat_bubble_outline_rounded,
                              color: AppColors.textSecondary,
                              size: 44.sp,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'No conversations yet.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.sm14Medium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () =>
                          controller.fetchConversations(showError: true),
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          top: 8.h,
                          left: 20.w,
                          right: 20.w,
                          bottom: 40.h,
                        ),
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
                          return _buildContactItem(contact, controller);
                        },
                      ),
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

  Widget _buildContactItem(ChatContact contact, ChatController controller) {
    return GestureDetector(
      onTap: () {
        controller.openConversation(contact);
        Get.to(() => ChatScreen(contact: contact));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFDEDEDE),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            _buildAvatar(contact.avatarUrl, 50.w),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: AppTextStyles.base16Medium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    contact.lastMessage,
                    style: AppTextStyles.sm14Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
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
                    style: AppTextStyles.sm14Regular.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String? avatarUrl, double size) {
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Image.network(
          avatarUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _avatarFallback(size),
        ),
      );
    }

    return _avatarFallback(size);
  }

  Widget _avatarFallback(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Icon(Icons.person, color: Colors.grey[600]),
    );
  }
}

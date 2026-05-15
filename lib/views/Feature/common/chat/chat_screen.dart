import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/AppColor/app_colors.dart';
import '../../../../utils/AppTextStyle/app_text_styles.dart';
import '../../../../controllers/common/chat_controller.dart';
import '../../../Base/CustomTextfield/CustomTextfield.dart';

class ChatScreen extends StatelessWidget {
  final ChatContact contact;
  const ChatScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.isRegistered<ChatController>()
        ? Get.find<ChatController>()
        : Get.put(ChatController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildAppBar(controller),
          Expanded(
            child: Obx(() {
              if (controller.isLoadingMessages.value &&
                  controller.messages.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.actionPrimary,
                  ),
                );
              }

              if (controller.messages.isEmpty) {
                return Center(
                  child: Text(
                    'No messages yet.',
                    style: AppTextStyles.sm14Medium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  bool showTimeDivider =
                      index == 0 ||
                      controller.messages[index].time !=
                          controller.messages[index - 1].time;

                  return Column(
                    children: [
                      if (showTimeDivider) _buildTimeDivider(message.time),
                      _buildMessageBubble(message),
                    ],
                  );
                },
              );
            }),
          ),
          _buildMessageInput(controller),
        ],
      ),
    );
  }

  Widget _buildAppBar(ChatController controller) {
    return Container(
      padding: EdgeInsets.only(
        top: 60.h,
        bottom: 20.h,
        left: 20.w,
        right: 20.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.actionPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20.sp,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          _buildAvatar(contact.avatarUrl, 40.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Obx(() {
              final selected = controller.selectedContact.value;
              return Text(
                selected?.name ?? contact.name,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.base16Medium.copyWith(color: Colors.white),
              );
            }),
          ),
          Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.info_outline, size: 24.sp, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDivider(String time) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: AppColors.borderPrimary)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              time,
              style: AppTextStyles.sm14Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(child: Divider(color: AppColors.borderPrimary)),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: message.isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isMe) ...[
            Container(
              width: 32.w,
              height: 32.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, color: Colors.grey[400], size: 20.sp),
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: message.isMe ? Colors.black : const Color(0xFFEBEBEB),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                message.text,
                style: AppTextStyles.sm14Medium.copyWith(
                  color: message.isMe ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          ),
          if (message.isMe) ...[
            SizedBox(width: 8.w),
            Container(
              width: 32.w,
              height: 32.w,
              decoration: const BoxDecoration(
                color: AppColors.actionPrimary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, color: Colors.white, size: 20.sp),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput(ChatController controller) {
    return Container(
      padding: EdgeInsets.only(
        top: 16.h,
        bottom: 40.h,
        left: 20.w,
        right: 20.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: controller.messageController,
              hintText: "Type a message...",
              suffixIcon: Icon(
                Icons.camera_alt_outlined,
                color: AppColors.textSecondary,
                size: 24.sp,
              ),
              filColor: Colors.white,
              borderColor: AppColors.borderSecondary,
            ),
          ),
          SizedBox(width: 12.w),
          Obx(
            () => GestureDetector(
              onTap: controller.isSending.value
                  ? null
                  : () => controller.sendMessage(),
              child: Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: controller.isSending.value
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Transform.rotate(
                          angle: -0.5,
                          child: Icon(
                            Icons.send_outlined,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String? avatarUrl, double size) {
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return ClipOval(
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
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person, color: Colors.grey[600], size: 24.sp),
    );
  }
}

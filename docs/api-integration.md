# API Integration Guide

This document maps the backend APIs currently wired into the Flutter app. Use it as the handoff guide for Flutter, backend, and QA developers.

## Source Of Truth

- Base URL: `lib/utils/AppConstants/app_constant.dart`
- Endpoint constants: `lib/core/network/api_endpoints.dart`
- HTTP client and auth headers: `lib/core/network/api_client.dart`
- Token persistence: `lib/core/storage/token_storage.dart`

Every new endpoint should be added to `ApiEndpoints` first, then consumed through a service class.

## Integration Pattern

1. Add endpoint in `ApiEndpoints`.
2. Add/extend a model in `lib/models`.
3. Add API method in `lib/services`.
4. Keep screen state and loading/errors inside a GetX controller in `lib/controllers`.
5. Bind controller data in `lib/views`.
6. Run `dart format` and `flutter analyze`.

## Auth

| Flow | Endpoint | Flutter Files | Status |
| --- | --- | --- | --- |
| Login | `POST /api/auth/login` | `AuthService.signIn`, `SignInController`, `AuthResponseModel` | Integrated |
| Refresh token | `POST /api/auth/refresh-token` | `AuthService.refreshToken` | Integrated |
| Member register | `POST /api/auth/register` multipart | `MemberRegisterController`, `MemberRegisterPayload`, identity verification flow | Integrated |
| Trainer register | `POST /api/auth/register/trainer` multipart | `TrainerRegisterController`, `TrainerRegisterPayload`, identity verification flow | Integrated |
| Verify email | `POST /api/auth/verify-email` | `AuthService.verifyEmail`, `PasswordVerificationScreen` | Integrated |
| Resend verification | `POST /api/auth/resend-verification` | `AuthService.resendVerification` | Integrated |
| Forgot password | `POST /api/auth/forgot-password` | `PasswordRecoveryController` | Integrated |
| Verify reset OTP | `POST /api/auth/verify-password-reset-otp` | `PasswordRecoveryController` | Integrated |
| Reset password | `POST /api/auth/reset-password` | `PasswordRecoveryController` | Integrated |
| Logout | `POST /api/auth/logout` | `AuthService.logout` | Integrated |

Notes:
- Login role is normalized from `roles`, `role`, `userRole`, `trainerProfile`, or `memberProfile`.
- Current image parser supports `profileImageUrl`, `imageUrl`, `profileImage`, `profile_picture`, `avatar`, and related snake_case variants.
- Social login is not integrated yet. Backend needs a social auth endpoint before Flutter can finish Google/Facebook/Apple login.

## User Profile

| Flow | Endpoint | Flutter Files | Status |
| --- | --- | --- | --- |
| Current user | `GET /api/users/me` | `UserService.getCurrentUser`, `UserProfileModel`, `TrainerProfileController`, `MemberProfileController` | Integrated |
| Change password | `PUT /api/users` | `UserService.changePassword`, trainer profile settings | Integrated |

Profile image behavior:
- Signup uploads the profile image as multipart field `image`.
- App reads `profileImageUrl` from `/api/users/me`.
- Relative image paths are normalized with `BASE_URL`.
- Member and trainer home/profile screens use the current user profile image.

## Member Assessment

| Flow | Endpoint | Flutter Files | Status |
| --- | --- | --- | --- |
| Get assessment | `GET /api/users/member-assessment` | Not fully wired | Pending |
| Update assessment | `PUT /api/users/member-assessment` | Not fully wired | Pending |

## Trainer Classes And Member Bookings

| Flow | Endpoint | Flutter Files | Status |
| --- | --- | --- | --- |
| Trainer list own classes | `GET /api/trainer/classes` | `TrainerClassService`, `MyClassesController` | Integrated |
| Trainer create class | `POST /api/trainer/classes` | `TrainerClassService`, create class bottom sheet | Integrated |
| Trainer class details | `GET /api/trainer/classes/{id}` | `TrainerClassService` | Integrated |
| Trainer update class | `PATCH /api/trainer/classes/{id}` | `TrainerClassService`, edit class bottom sheet | Integrated |
| Trainer delete/cancel class | `DELETE /api/trainer/classes/{id}` | `TrainerClassService` | Integrated |
| Member list classes | `GET /api/member/classes` | Service endpoint exists | Partial |
| Member book class | `POST /api/member/classes/{id}/book` | Service endpoint exists | Partial |
| Member bookings | `GET /api/member/bookings` | Service endpoint exists | Partial |
| Member next booking | `GET /api/member/bookings/next` | Service endpoint exists | Partial |

Pending product rules from client:
- Trainers can create fixed one-time classes and services with availability slots.
- Members can book multiple slots/days.
- Payment success should confirm booking immediately.
- Payment incomplete should reserve selected slots for one hour.
- Group classes need capacity.
- Private sessions should block the slot after one booking.

Backend needs final request/response contracts for these rules before Flutter can finish the booking UI.

## Location And Trainer Search

| Flow | Endpoint | Flutter Files | Status |
| --- | --- | --- | --- |
| Set trainer base location | `POST /api/location/trainer/base` | `LocationService`, `TrainerLocationController` | Integrated |
| Update trainer live location | `PUT /api/location/trainer/live` | `LocationService`, `TrainerLocationController` | Integrated |
| Clear live location | `DELETE /api/location/trainer/live` | Endpoint not added yet | Pending |
| Update online status | `PUT /api/location/trainer/status` | `LocationService`, `TrainerLocationController` | Integrated |
| Save member location | `POST /api/location/member` | `LocationService`, member home/list controllers | Integrated |
| Nearby trainers | `GET /api/trainers/nearby` | `LocationService`, `MemberHomeController`, `TrainerListController` | Integrated |
| Search trainers | `GET /api/trainers/search` | `LocationService`, `TrainerListController` | Integrated |
| Trainer profile | `GET /api/trainers/{id}` | `LocationService`, `TrainerDetailsController`, `TrainerProfileModel` | Integrated |

Chat uses `trainerUserId`, so trainer list/detail models preserve this field separately from display profile id when available.

## Chat

| Flow | Endpoint | Flutter Files | Status |
| --- | --- | --- | --- |
| Start/get conversation | `POST /api/chat/conversations` | `ChatService.startConversation`, `ChatController.startConversationWithTrainer` | Integrated |
| List conversations | `GET /api/chat/conversations` | `ChatService.getConversations`, `MessagesListScreen` | Integrated |
| List messages | `GET /api/chat/conversations/{conversationId}/messages` | `ChatService.getMessages`, `ChatScreen` | Integrated |
| Send message | `POST /api/chat/conversations/{conversationId}/messages` | `ChatService.sendMessage`, `ChatController.sendMessage` | Integrated |
| Mark seen | `PATCH /api/chat/conversations/{conversationId}/seen` | `ChatService.markSeen` | Integrated |

Current chat logic follows the provided API: member-trainer conversation using `trainerUserId`.

Not integrated yet:
- Real-time WebSocket/Socket.IO.
- Attachment picker/upload UI.
- Admin-only chat. This needs a different backend API, because the current API starts member-trainer conversations.

## Countries

| Flow | Endpoint | Flutter Files | Status |
| --- | --- | --- | --- |
| List countries | `GET /api/countries` | `CountryService`, `CountryModel` | Integrated service |
| Country by ISO3 | `GET /api/countries/code-iso3/{codeIso3}` | `CountryService` | Integrated service |
| Country by code | `GET /api/countries/code/{code}` | `CountryService` | Integrated service |

UI usage is still limited.

## Backend Contracts Still Needed

Ask backend for these before implementing more Flutter work:

- Social auth endpoint for Google/Facebook/Apple.
- Real-time chat socket URL, auth method, event names, and payload examples.
- Admin/support chat endpoint if chat should be user-admin instead of member-trainer.
- Final booking/payment contracts for slot holds, capacity, group/private sessions, and payment status.
- Member assessment final response examples.

## QA Checklist

- Login as trainer and member, confirm role-based routing.
- Signup with profile image, verify email, then confirm `/api/users/me` shows `profileImageUrl`.
- Check profile image on home/profile/personal info screens.
- Member opens trainer details, taps chat, sends message.
- Trainer opens Messages tab and sees conversation/message.
- Trainer creates, updates, and deletes a class.
- Member nearby trainer list loads from API.

## Updating This Doc

When adding an API:

1. Add the endpoint and service method.
2. Add the model/controller/screen references here.
3. Mark status as `Integrated`, `Partial`, or `Pending`.
4. Add known backend or UI blockers under the relevant section.

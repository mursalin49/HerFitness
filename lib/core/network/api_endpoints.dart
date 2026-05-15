class ApiEndpoints {
  const ApiEndpoints._();

  static const signIn = '/api/auth/login';
  static const refreshToken = '/api/auth/refresh-token';
  static const verifyEmail = '/api/auth/verify-email';
  static const resendVerification = '/api/auth/resend-verification';
  static const memberSignUp = '/api/auth/register';
  static const trainerSignUp = '/api/auth/register/trainer';
  static const forgotPassword = '/api/auth/forgot-password';
  static const verifyPasswordResetOtp = '/api/auth/verify-password-reset-otp';
  static const resetPassword = '/api/auth/reset-password';
  static const logout = '/api/auth/logout';
  static const identityVerification = '/identity-verification';
  static const users = '/api/users';
  static const currentUser = '/api/users/me';
  static const trainerClasses = '/api/trainer/classes';
  static String trainerClassById(String id) => '/api/trainer/classes/$id';
  static const memberClasses = '/api/member/classes';
  static String memberBookClass(String id) => '/api/member/classes/$id/book';
  static const memberBookings = '/api/member/bookings';
  static const memberNextBooking = '/api/member/bookings/next';
  static const trainerBaseLocation = '/api/location/trainer/base';
  static const trainerLiveLocation = '/api/location/trainer/live';
  static const trainerOnlineStatus = '/api/location/trainer/status';
  static const memberLocation = '/api/location/member';
  static const nearbyTrainers = '/api/trainers/nearby';
  static const searchTrainers = '/api/trainers/search';
  static String apiTrainerDetails(String id) => '/api/trainers/$id';
  static const chatConversations = '/api/chat/conversations';
  static String chatConversationMessages(String conversationId) =>
      '/api/chat/conversations/$conversationId/messages';
  static String chatConversationSeen(String conversationId) =>
      '/api/chat/conversations/$conversationId/seen';
  static const countries = '/api/countries';
  static String countryByIso3(String codeIso3) =>
      '/api/countries/code-iso3/$codeIso3';
  static String countryByCode(String code) => '/api/countries/code/$code';

  static const trainers = '/trainers';
  static const trainerDetails = '/trainers';
  static const classes = '/classes';
}

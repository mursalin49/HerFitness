import 'dart:io';

import 'package:fitness/core/network/api_client.dart';
import 'package:fitness/core/network/api_endpoints.dart';
import 'package:fitness/core/storage/token_storage.dart';
import 'package:fitness/models/auth_response_model.dart';
import 'package:fitness/models/trainer_register_payload.dart';

class AuthService {
  AuthService({ApiClient? apiClient, TokenStorage? tokenStorage})
    : _apiClient = apiClient ?? ApiClient.instance,
      _tokenStorage = tokenStorage ?? TokenStorage();

  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  Future<AuthResponseModel> signIn({
    required String username,
    required String password,
    bool rememberMe = false,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.signIn,
      body: {
        'username': username,
        'password': password,
        'rememberMe': rememberMe,
      },
    );

    final authResponse = _parseAuthResponse(response);
    await _saveAuthResponse(authResponse);

    return authResponse;
  }

  Future<AuthResponseModel> refreshToken() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw const ApiException('Refresh token not found');
    }

    final response = await _apiClient.post(
      ApiEndpoints.refreshToken,
      body: {'refreshToken': refreshToken},
    );

    final authResponse = _parseAuthResponse(response);
    await _saveAuthResponse(authResponse);

    return authResponse;
  }

  Future<dynamic> verifyEmail({
    required String email,
    required String code,
  }) async {
    return _apiClient.post(
      ApiEndpoints.verifyEmail,
      body: {'email': email, 'code': code},
    );
  }

  Future<dynamic> resendVerification({required String email}) async {
    return _apiClient.post(
      ApiEndpoints.resendVerification,
      body: {'email': email},
    );
  }

  Future<dynamic> forgotPassword({required String email}) async {
    return _apiClient.post(ApiEndpoints.forgotPassword, body: {'email': email});
  }

  Future<dynamic> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    return _apiClient.post(
      ApiEndpoints.resetPassword,
      body: {
        'email': email,
        'code': code,
        'newPassword': newPassword,
        'confirmNewPassword': confirmNewPassword,
      },
    );
  }

  Future<void> _saveAuthResponse(AuthResponseModel authResponse) async {
    if (authResponse.accessToken.isNotEmpty) {
      await _tokenStorage.saveAuthTokens(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
      );
    }

    final role = authResponse.user?.role;
    if (role != null && role.isNotEmpty) {
      await _tokenStorage.saveUserRole(role);
    }
  }

  AuthResponseModel _parseAuthResponse(dynamic response) {
    return AuthResponseModel.fromJson(response as Map<String, dynamic>);
  }

  Future<dynamic> registerTrainer(TrainerRegisterPayload payload) async {
    try {
      _ensureFileExists(payload.imagePath, 'Profile image');
      _ensureFileExists(payload.idCardFrontImagePath, 'ID card front image');
      _ensureFileExists(payload.idCardBackImagePath, 'ID card back image');

      return _apiClient.multipartPost(
        endpoint: ApiEndpoints.trainerSignUp,
        fields: payload.fields,
        files: await payload.toMultipartFiles(),
      );
    } on ApiException {
      rethrow;
    } on FileSystemException catch (error) {
      throw ApiException(error.message);
    } catch (error) {
      throw ApiException(error.toString());
    }
  }

  void _ensureFileExists(String path, String label) {
    if (path.trim().isEmpty) {
      throw ApiException('$label is missing. Please select it again.');
    }

    if (!File(path).existsSync()) {
      throw ApiException('$label file was not found. Please select it again.');
    }
  }

  Future<void> logout() async {
    try {
      await _apiClient.post(ApiEndpoints.logout);
    } finally {
      await _tokenStorage.clear();
    }
  }
}

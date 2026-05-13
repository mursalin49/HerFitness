import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fitness/core/storage/token_storage.dart';
import 'package:fitness/utils/AppConstants/app_constant.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient({http.Client? httpClient, TokenStorage? tokenStorage})
    : _httpClient = httpClient ?? http.Client(),
      _tokenStorage = tokenStorage ?? TokenStorage();

  static final ApiClient instance = ApiClient();

  final http.Client _httpClient;
  final TokenStorage _tokenStorage;

  static const Duration _timeout = Duration(seconds: 30);

  String get _baseUrl => AppConstants.BASE_URL.trim();

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _send(
      () async => _httpClient.get(
        _buildUri(endpoint, queryParameters: queryParameters),
        headers: await _headers(hasJsonBody: false),
      ),
    );
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    return _send(
      () async => _httpClient.post(
        _buildUri(endpoint),
        headers: await _headers(),
        body: jsonEncode(body ?? <String, dynamic>{}),
      ),
    );
  }

  Future<dynamic> put(String endpoint, {Map<String, dynamic>? body}) async {
    return _send(
      () async => _httpClient.put(
        _buildUri(endpoint),
        headers: await _headers(),
        body: jsonEncode(body ?? <String, dynamic>{}),
      ),
    );
  }

  Future<dynamic> patch(String endpoint, {Map<String, dynamic>? body}) async {
    return _send(
      () async => _httpClient.patch(
        _buildUri(endpoint),
        headers: await _headers(),
        body: jsonEncode(body ?? <String, dynamic>{}),
      ),
    );
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _send(
      () async => _httpClient.delete(
        _buildUri(endpoint, queryParameters: queryParameters),
        headers: await _headers(hasJsonBody: false),
      ),
    );
  }

  Future<dynamic> multipartPost({
    required String endpoint,
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
  }) async {
    try {
      final request = http.MultipartRequest('POST', _buildUri(endpoint));
      request.headers.addAll(await _headers(hasJsonBody: false));
      request.fields.addAll(fields);
      request.files.addAll(files);

      final streamedResponse = await request.send().timeout(_timeout);
      final response = await http.Response.fromStream(streamedResponse);
      return _handleResponse(response);
    } on SocketException {
      throw ApiException('No internet connection');
    } on TimeoutException {
      throw ApiException('Request timed out. Please try again.');
    } on FormatException {
      throw ApiException('Invalid server response');
    }
  }

  Future<Map<String, String>> _headers({bool hasJsonBody = true}) async {
    final token = await _tokenStorage.getAccessToken();

    return {
      'Accept': 'application/json',
      if (hasJsonBody) 'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Uri _buildUri(String endpoint, {Map<String, dynamic>? queryParameters}) {
    final normalizedEndpoint = endpoint.trim();

    if (normalizedEndpoint.startsWith('http')) {
      return Uri.parse(
        normalizedEndpoint,
      ).replace(queryParameters: _normalizeQueryParameters(queryParameters));
    }

    if (_baseUrl.isEmpty) {
      throw ApiException('BASE_URL is missing from AppConstants');
    }

    final baseUrl = _baseUrl.endsWith('/')
        ? _baseUrl.substring(0, _baseUrl.length - 1)
        : _baseUrl;
    final path = normalizedEndpoint.startsWith('/')
        ? normalizedEndpoint
        : '/$normalizedEndpoint';

    return Uri.parse(
      '$baseUrl$path',
    ).replace(queryParameters: _normalizeQueryParameters(queryParameters));
  }

  Map<String, String>? _normalizeQueryParameters(
    Map<String, dynamic>? parameters,
  ) {
    if (parameters == null || parameters.isEmpty) return null;

    return parameters.map((key, value) => MapEntry(key, value.toString()));
  }

  Future<dynamic> _send(Future<http.Response> Function() request) async {
    try {
      final response = await request().timeout(_timeout);
      return _handleResponse(response);
    } on SocketException {
      throw ApiException('No internet connection');
    } on TimeoutException {
      throw ApiException('Request timed out. Please try again.');
    } on FormatException {
      throw ApiException('Invalid server response');
    }
  }

  dynamic _handleResponse(http.Response response) {
    final decodedBody = _decodeBody(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decodedBody;
    }

    throw ApiException(
      _extractErrorMessage(decodedBody),
      statusCode: response.statusCode,
      data: decodedBody,
    );
  }

  dynamic _decodeBody(String body) {
    if (body.isEmpty) return <String, dynamic>{};
    return jsonDecode(body);
  }

  String _extractErrorMessage(dynamic body) {
    if (body is Map<String, dynamic>) {
      final message = body['message'] ?? body['error'];
      if (message != null) return message.toString();

      final errors = body['errors'];
      if (errors is Map && errors.isNotEmpty) {
        final firstError = errors.values.first;
        if (firstError is List && firstError.isNotEmpty) {
          return firstError.first.toString();
        }
        return firstError.toString();
      }
    }

    return 'Something went wrong. Please try again.';
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException(this.message, {this.statusCode, this.data});

  @override
  String toString() => message;
}

import 'package:fitness/core/network/api_client.dart';
import 'package:fitness/core/network/api_endpoints.dart';
import 'package:fitness/models/trainer_class_model.dart';

class TrainerClassService {
  TrainerClassService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  Future<List<TrainerClassModel>> getClasses() async {
    final response = await _apiClient.get(ApiEndpoints.trainerClasses);
    return _extractList(response)
        .whereType<Map<String, dynamic>>()
        .map(TrainerClassModel.fromJson)
        .toList();
  }

  Future<TrainerClassModel> getClassById(String id) async {
    final response = await _apiClient.get(ApiEndpoints.trainerClassById(id));
    final data = _extractObjectOrNull(response);
    if (data == null) {
      throw const ApiException('Class was not found.');
    }

    return TrainerClassModel.fromJson(data);
  }

  Future<TrainerClassModel?> createClass(TrainerClassPayload payload) async {
    final response = await _apiClient.post(
      ApiEndpoints.trainerClasses,
      body: payload.toJson(),
    );
    final data = _extractObjectOrNull(response);
    return data == null ? null : TrainerClassModel.fromJson(data);
  }

  Future<TrainerClassModel?> updateClass({
    required String id,
    required TrainerClassPayload payload,
  }) async {
    final response = await _apiClient.patch(
      ApiEndpoints.trainerClassById(id),
      body: payload.toJson(),
    );
    final data = _extractObjectOrNull(response);
    return data == null ? null : TrainerClassModel.fromJson(data);
  }

  Future<void> deleteClass(String id) async {
    await _apiClient.delete(ApiEndpoints.trainerClassById(id));
  }

  List<dynamic> _extractList(dynamic response) {
    if (response is List) return response;
    if (response is! Map<String, dynamic>) {
      throw const ApiException('Invalid server response');
    }

    final data = response['data'];
    if (data is List) return data;
    if (data is Map<String, dynamic>) {
      for (final key in const ['items', 'classes', 'results']) {
        final value = data[key];
        if (value is List) return value;
      }
    }

    for (final key in const ['items', 'classes', 'results']) {
      final value = response[key];
      if (value is List) return value;
    }

    return const [];
  }

  Map<String, dynamic>? _extractObjectOrNull(dynamic response) {
    if (response is! Map<String, dynamic>) {
      throw const ApiException('Invalid server response');
    }

    if (response.isEmpty) return null;

    final data = response['data'];
    if (data is Map<String, dynamic>) {
      final nested = data['class'] ?? data['service'];
      if (nested is Map<String, dynamic>) return nested;
      return data;
    }

    final nested = response['class'] ?? response['service'];
    if (nested is Map<String, dynamic>) return nested;

    if (response.containsKey('message') && response.length == 1) {
      return null;
    }

    return response;
  }
}

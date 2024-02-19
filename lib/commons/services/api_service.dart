import 'package:dio/dio.dart';

class APIService {
  static Future<void> fetch(
    String endpoint, {
    Map<String, dynamic>? params,
    required Function(dynamic response) onSuccess,
    required Function(String error) onFailure,
  }) async {
    final dio = Dio();

    try {
      final result = await dio.get(
        endpoint,
      );

      onSuccess(result.data);
    } catch (e) {
      onFailure(e.toString());
    }
  }
}

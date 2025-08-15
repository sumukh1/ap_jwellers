import '../impl/app_http_response.dart';

abstract class AppHttp {
  Future<AppHttpResponse> post({
    required String path,
    Object? data,
    bool token = true,
    Map<String, dynamic>? queryParameters,
  });

  Future<AppHttpResponse> get({
    required String path,
    bool token = true,
    Map<String, dynamic>? queryParameters,
  });

  Future<AppHttpResponse> update({
    required String path,
    Object? data,
    bool token = true,
    Map<String, dynamic>? queryParameters,
  });

  Future<AppHttpResponse> delete({
    required String path,
    Object? data,
    bool token = true,
    Map<String, dynamic>? queryParameters,
  });

  Future<AppHttpResponse> put({
    required String path,
    Object? data,
    bool token = true,
    Map<String, dynamic>? queryParameters,
  });

  Future<AppHttpResponse> putFile({
    required String path,
    Object? data,
    bool token = true,
    Map<String, dynamic>? queryParameters,
  });
}

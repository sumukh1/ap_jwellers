import '../abstract/app_http_data.dart';

class AppHttpResponse {
  final int statusCode;
  final dynamic data;
  AppHttpResponse({required this.statusCode, required this.data});
}

class PostHttpData extends AppHttpData {
  String timestamp;
  String message;
  dynamic response;
  String status;
  int statusCode;
  bool success;
  PostHttpData(
      {required this.timestamp,
      required this.message,
      required this.status,
      required this.statusCode,
      required this.response,
      this.success = false});
}

class GetHttpData extends AppHttpData {
  String timestamp;
  String message;
  dynamic response;
  String status;
  int statusCode;
  bool success;
  GetHttpData(
      {required this.timestamp,
      required this.message,
      required this.response,
      required this.status,
      required this.statusCode,
      this.success = false});
  factory GetHttpData.fromMap(Map<String, dynamic> map) {
    return GetHttpData(
      timestamp: map['timestamp'] ?? '',
      message: map['message'] ?? '',
      response: map['response'],
      status: map['status'] ?? '',
      statusCode: map['statusCode'] ?? 0,
      success: map['success'] ?? false,
    );
  }
}

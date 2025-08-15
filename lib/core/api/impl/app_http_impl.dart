import 'dart:convert';

import 'package:myapp/core/api/abstract/app_http.dart';
import 'package:myapp/core/api/impl/app_http_response.dart';
import 'package:myapp/core/services/app_storage.dart';
import 'package:myapp/core/services/log_utility.dart';
import 'package:myapp/static/AppStorageKeys.dart';
import 'package:http/http.dart' as http;

class AppHttpImpl extends AppHttp {
  AppHttpImpl(this.appStorage);
  final AppStorage appStorage;

  static final defaulPosttHeader = {
    'Content-Type': 'application/json',
  };
  static final defaulGettHeader = {
    'Accept': 'application/json',
  };
  static final fileHeader = {'Content-Type': 'mimeType'};
  @override
  delete(
      {required String path,
      Object? data,
      bool token = true,
      Map<String, dynamic>? queryParameters}) async {
    //ADD PARAMS
    path += paramString(queryParameters: queryParameters);
    //AJAX CALL
    final response = await http.delete(Uri.parse(path),
        headers:
            token ? await tokentHeader(defaulPosttHeader) : defaulPosttHeader,
        body: data != null ? jsonEncode(data) : null);
    var httpData = {};

    if (response.statusCode == 200 || response.statusCode == 500) {
      final res = jsonDecode(response.body) as Map<String, dynamic>;
      httpData = res;
    }
    final res =
        AppHttpResponse(statusCode: response.statusCode, data: httpData);
    LogUtility.warning("DELETE API : $path");
    LogUtility.warning("Body : ${data.toString()}");
    LogUtility.warning("[${response.statusCode}]Response ${response.body}");
    return res;
  }

  @override
  get(
      {required String path,
      bool token = true,
      Map<String, dynamic>? queryParameters}) async {
    //ADD PARAMS
    path += paramString(queryParameters: queryParameters);
    //AJAX CALL
    final response = await http.get(
      Uri.parse(path),
      headers: token ? await tokentHeader(defaulGettHeader) : defaulGettHeader,
    );
    var httpData = {};

    LogUtility.warning("GET API : $path");
    LogUtility.warning("Body : ");
    if (response.statusCode == 200 || response.statusCode == 500) {
      LogUtility.warning("[${response.statusCode}]Response ${response.body}");
      final res = jsonDecode(response.body) as Map<String, dynamic>;
      httpData = res;
    }
    final res =
        AppHttpResponse(statusCode: response.statusCode, data: httpData);
    return res;
  }

  @override
  post(
      {required String path,
      Object? data,
      bool token = true,
      Map<String, dynamic>? queryParameters}) async {
    //ADD PARAMS
    path += paramString(queryParameters: queryParameters);
    //AJAX CALL
    final response = await http.post(Uri.parse(path),
        headers:
            token ? await tokentHeader(defaulPosttHeader) : defaulPosttHeader,
        body: data != null ? jsonEncode(data) : null);
    var httpData = {};

    LogUtility.warning("POST API : $path");
    LogUtility.warning("Body : ${data.toString()}");
    LogUtility.warning("Response ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 500) {
      final res = jsonDecode(response.body) as Map<String, dynamic>;
      httpData = res;
    }
    final res =
        AppHttpResponse(statusCode: response.statusCode, data: httpData);
    return res;
  }

  @override
  put(
      {required String path,
      Object? data,
      bool token = true,
      Map<String, dynamic>? queryParameters}) async {
    //ADD PARAMS
    path += paramString(queryParameters: queryParameters);
    //AJAX CALL
    final response = await http.put(Uri.parse(path),
        headers:
            token ? await tokentHeader(defaulPosttHeader) : defaulPosttHeader,
        body: data != null ? jsonEncode(data) : null);
    var httpData = {};

    if (response.statusCode == 200 || response.statusCode == 500) {
      final res = jsonDecode(response.body) as Map<String, dynamic>;
      httpData = res;
    }
    final res =
        AppHttpResponse(statusCode: response.statusCode, data: httpData);
    LogUtility.warning("PUT API : $path");
    LogUtility.warning("Body : ${data.toString()}");
    LogUtility.warning("[${response.statusCode}]Response ${response.body}");
    return res;
  }

  @override
  update(
      {required String path,
      Object? data,
      bool token = true,
      Map<String, dynamic>? queryParameters}) async {
    //ADD PARAMS
    path += paramString(queryParameters: queryParameters);
    //AJAX CALL
    final response = await http.put(Uri.parse(path),
        headers:
            token ? await tokentHeader(defaulPosttHeader) : defaulPosttHeader,
        body: data != null ? jsonEncode(data) : null);
    var httpData = {};

    if (response.statusCode == 200 || response.statusCode == 500) {
      final res = jsonDecode(response.body) as Map<String, dynamic>;
      httpData = res;
    }
    final res =
        AppHttpResponse(statusCode: response.statusCode, data: httpData);
    return res;
  }

  @override
  putFile(
      {required String path,
      Object? data,
      bool token = true,
      Map<String, dynamic>? queryParameters}) async {
    path += paramString(queryParameters: queryParameters);
    final request = http.MultipartRequest('POST', Uri.parse(path));
    request.headers.addAll(token ? await tokentHeader(fileHeader) : fileHeader);
    for (Map<String, dynamic> fileData in data as List<Map<String, dynamic>>) {
      final path = fileData['path'] as String;
      final field = fileData['field'] as String;
      request.files.add(
        await http.MultipartFile.fromPath(
          field,
          path,
        ),
      );
    }

    final response = await http.Response.fromStream(await request.send());
    var httpData = {};
    if (response.statusCode == 200 || response.statusCode == 500) {
      final res = jsonDecode(response.body) as Map<String, dynamic>;
      httpData = res;
    }
    final res =
        AppHttpResponse(statusCode: response.statusCode, data: httpData);
    return res;
  }

  Future<Map<String, String>> tokentHeader(Map<String, String> header) async {
    final token = await appStorage.read(Appstoragekeys.token);
    header["Authorization"] = "Bearer $token";
    return header;
  }
}

String paramString({required Map<String, dynamic>? queryParameters}) {
  String path = "";
  if (queryParameters != null) {
    int j = 0;
    for (int i = 0; i < queryParameters.keys.length; i++) {
      if (queryParameters.values.elementAt(i) == null) {
        continue;
      }
      if (j == 0) {
        path +=
            "?${queryParameters.keys.elementAt(i)}=${queryParameters.values.elementAt(i)}";
      } else {
        path +=
            "&${queryParameters.keys.elementAt(i)}=${queryParameters.values.elementAt(i)}";
      }
      j++;
    }
  }
  return path;
}

PostHttpData postFromBody({required Map<String, dynamic> res}) {
  return PostHttpData(
      timestamp: res['timestamp'] ?? "",
      message: res['message'] ?? "",
      status: res['status'] ?? "",
      statusCode: res['statusCode'] ?? 0,
      success: res['success'] ?? false,
      response: res['response'] ?? "");
}

// final getFromBody({required Map<String, dynamic> res}) {
//   return final(
//       timestamp: res['timestamp'] ?? "",
//       message: res['message'] ?? "",
//       status: res['status'] ?? "",
//       statusCode: res['statusCode'] ?? 0,
//       success: res['success'] ?? false,
//       response: res['response'] ?? "");
// }

import 'package:equatable/equatable.dart';

abstract class Response extends Equatable {
  const Response();
  factory Response.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError('fromMap must be implemented in a subclass');
  }
  static List<Response> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Response.fromMap(map)).toList();
  }
}

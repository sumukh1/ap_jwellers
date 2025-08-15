import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:go_router/go_router.dart';

class AppNavigator {
  static void push(BuildContext context, String path) {
    if (kIsWeb) {
      GoRouter.of(context).go(path);
    } else {
      GoRouter.of(context).push(path);
    }
  }

  static void pop(BuildContext context) {
    GoRouter.of(context).pop();
  }

  static void pushReplacement(BuildContext context, String path) {
    GoRouter.of(context).pushReplacement(path);
  }

  static void pushAndRemoveUntil(BuildContext context, String path) {
    GoRouter.of(context).go(path);
  }
}

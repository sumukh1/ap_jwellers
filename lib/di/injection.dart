import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/api/abstract/app_http.dart';
import 'package:myapp/core/api/impl/app_http_impl.dart';
import 'package:myapp/core/services/app_storage.dart';
import 'package:myapp/core/services/firebase_notification_mobile.dart';
import 'package:myapp/core/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

part 'injection_bloc.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  static BuildContext get currentContext => navigatorState.currentContext!;
  static AppStorage get appStorage => getIt<AppStorage>();
  static NotificationService get notificationService =>
      getIt<NotificationService>();

  static NavigationService get navigationService {
    return getIt<NavigationService>();
  }

  static GlobalKey<NavigatorState> get navigatorState {
    return getIt<NavigationService>().navigatorKey;
  }

  static Future<void> _initServicesAndUtils() async {
    getIt.registerLazySingleton<NavigationService>(() => NavigationService());

    getIt.registerSingleton<AppStorage>(
        AppStorage(storage: await SharedPreferences.getInstance()));

    final appHttp = AppHttpImpl(getIt<AppStorage>());
    getIt.registerLazySingleton<AppHttp>(() => appHttp);
    //NOTIFICATION
    if (!kIsWeb) {
      getIt.registerLazySingleton<FirebaseMessaging>(
        () => FirebaseMessaging.instance,
      );

      getIt.registerLazySingleton<NotificationService>(
        () => NotificationService(getIt<FirebaseMessaging>()),
      );
    } else {
      getIt.registerLazySingleton<NotificationService>(
          () => NotificationService(null));
    }
  }

  static Future<void> _initSystemSettings() async {}
  static Future<void> _initialDependency() async {
    // await __authDependancy();
  }

  static Future<void> init() async {
    await _initSystemSettings();
    await _initServicesAndUtils();
    await _initialDependency();
  }
}

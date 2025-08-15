// import 'dart:async';
// import 'dart:io';
// import 'package:myapp/core/services/log_utility.dart';
// import 'package:alarm/alarm.dart';

// typedef AlarmRingCallback = Future<void> Function(AlarmSettings alarmSettings);

// class AlarmService {
//   static StreamSubscription<AlarmSettings>? _subscription;

//   static void listenToAlarmRing(AlarmRingCallback onRing) {
//     _subscription ??= Alarm.ringStream.stream.listen(onRing);
//   }

//   static void cancelListener() {
//     _subscription?.cancel();
//     _subscription = null;
//   }

//   static Future<void> addAlarm(int id, DateTime dateTime, String msg) async {
//     final newAlarm = AlarmSettings(
//       id: id,
//       dateTime: dateTime,
//       assetAudioPath: 'assets/audio/alarm.wav',
//       loopAudio: true,
//       vibrate: true,
//       volume: 0.8,
//       fadeDuration: 3.0,
//       notificationTitle: 'Meeting Alarm',
//       notificationBody: msg,
//       enableNotificationOnKill: Platform.isIOS,
//     );
//     await Alarm.set(alarmSettings: newAlarm);
//     LogUtility.warning(
//       'Alarm set: id=$id, dateTime=${dateTime.toIso8601String()}, msg=$msg',
//     );
//   }

//   static Future<void> deleteAlarm(int id) async {
//     await Alarm.stop(id);
//   }

//   static Future<void> editAlarm(
//       int id, DateTime newDateTime, String newMsg) async {
//     await Alarm.stop(id);
//     await addAlarm(id, newDateTime, newMsg);
//   }
// }

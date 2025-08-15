// import 'package:alarm/alarm.dart';
// import 'package:flutter/material.dart';

// class AlarmScreen extends StatefulWidget {
//   final AlarmSettings alarmSettings;
//   const AlarmScreen({super.key, required this.alarmSettings});

//   @override
//   State<AlarmScreen> createState() => _AlarmScreenState();
// }

// class _AlarmScreenState extends State<AlarmScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'AEI ALARM',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 28,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'MEETING TIME',
//                 style: TextStyle(
//                   color: Color(0xFF007AFF),
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 1.5,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               const Text(
//                 'Set Alarm',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 TimeOfDay.fromDateTime(widget.alarmSettings.dateTime).format(context),
//                 style: const TextStyle(
//                   color: Color(0xFF007AFF),
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 32),
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF1C1C1E),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Icon(Icons.notifications_active_rounded, color: Color(0xFF007AFF), size: 28),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         widget.alarmSettings.notificationBody,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF2C2C2E),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () {
//                         final now = DateTime.now();
//                         Alarm.set(
//                           alarmSettings: widget.alarmSettings.copyWith(
//                             dateTime: now.add(const Duration(minutes: 1)),
//                           ),
//                         ).then((_) => Navigator.pop(context));
//                       },
//                       child: const Text(
//                         'NOTIFY ME',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           letterSpacing: 1.2,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF2C2C2E),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () {
//                         Alarm.stop(widget.alarmSettings.id).then((_) => Navigator.pop(context));
//                       },
//                       child: const Text(
//                         'OK',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           letterSpacing: 1.2,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

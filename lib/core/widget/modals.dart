// // import 'package:myapp/core/di/injection.dart';
// import 'package:myapp/static/AppColors.dart';
// import 'package:myapp/static/AppStorageKeys.dart';
// import 'package:myapp/static/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';

// Future<bool?> showPinDialog(BuildContext context) async {
//   final defaultPinTheme = PinTheme(
//     width: 50,
//     height: 50,
//     textStyle:  TextStyle(
//       fontSize: 24,
//       color: Constants.BLACK,
//       fontWeight: FontWeight.w600,
//     ),
//     decoration: BoxDecoration(
//       color: Colors.grey.shade400,
//       borderRadius: BorderRadius.circular(10),
//     ),
//   );
//   final selectedPin = await Injection.appStorage.read(Appstoragekeys.pin) ?? "";
//   return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           TextEditingController pinController = TextEditingController();
//           return AlertDialog(
//             title: Text('Enter PIN'),
//             backgroundColor: Constants.BACKGROUND,
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Pinput(
//                   controller: pinController,
//                   length: 6,
//                   defaultPinTheme: defaultPinTheme,
//                   // obscureText: true,
//                   onCompleted: (pin) {
//                     if (pin == selectedPin) {
//                       Navigator.of(context).pop(true);
//                     } else {
//                       Navigator.of(context).pop(false);
//                     }
//                   },
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(false);
//                 },
//                 child: Text(
//                   'Cancel',
//                   style: TextStyle(color: AppColors.darkBlue),
//                 ),
//               ),
//             ],
//           );
//         },
//       );
// }

// Future<void> appDialog(
//     {required BuildContext context,
//     required Widget child,
//     String? title}) async {
//   return showDialog<void>(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         backgroundColor: Constants.WHITE, // Customize the background color
//         shape: RoundedRectangleBorder(
//           side: BorderSide(color: Constants.BLACK, width: 1),
//           borderRadius: BorderRadius.circular(0),
//         ),
//         title: Align(
//           alignment: Alignment.center,
//           child: Text(
//             title ?? '',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: AppColors.darkBlue,
//             ),
//           ),
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         content: child,
//       );
//     },
//   );
// }

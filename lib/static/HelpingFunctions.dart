import 'dart:io';
import 'dart:typed_data';
import 'package:myapp/core/widget/loading.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'dart:async';
import 'package:myapp/core/services/log_utility.dart';
import 'package:flutter/material.dart';

const int maxPhoneSize = 540;
const int maxTabletSize = 899;
const int maxLaptopSize = 1999;
const int maxDesktopSize = 2500;

dynamic screenDependValue({
  required BuildContext context,
  required dynamic laptop,
  required dynamic phone,
  required dynamic tablet,
  required dynamic desktop,
}) {
  if (MediaQuery.of(context).size.width <= maxPhoneSize) {
    return phone;
  } else if (MediaQuery.of(context).size.width <= maxTabletSize) {
    return tablet;
  } else if (MediaQuery.of(context).size.width <= maxLaptopSize) {
    return laptop;
  } else {
    return desktop;
  }
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

//FormNotEmptyValidator
class FormNotEmptyValidator {
  static bool validate(List values) {
    for (var value in values) {
      if (value == null ||
          (value is String && value.isEmpty) ||
          (value.toString().trim().isEmpty) ||
          (value is bool && !value)) {
        return false;
      }
    }
    return true;
  }
}

class HighlightText extends StatelessWidget {
  const HighlightText(
      {super.key,
      required this.text,
      required this.searchText,
      this.style,
      this.textAlign,
      this.color});
  final String text;
  final String searchText;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Color? color;

  final int maxLines = 1;

  @override
  Widget build(BuildContext context) {
    String lowerCaseText = text.toLowerCase();
    String lowerCaseSearchText = searchText.toLowerCase();
    int startIndex = lowerCaseText.indexOf(lowerCaseSearchText);
    LogUtility.warning(startIndex.toString());
    if (startIndex == -1 || lowerCaseSearchText == '') {
      return Text(
        text,
        style: style,
      );
    }
    int endIndex = startIndex + searchText.length;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text.substring(0, startIndex),
            style: style,
          ),
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: style != null
                ? style!.copyWith(
                    color: color ?? Colors.red,
                  )
                : TextStyle(
                    color: color ?? Colors.red, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: text.substring(endIndex),
            style: style,
          ),
        ],
      ),
    );
  }
}

String normalizeString(String input) {
  // Decompose Unicode characters to their base form and diacritics
  var decomposed = input.characters.toString();

  // Remove combining diacritical marks
  var normalized = decomposed.replaceAll(RegExp(r'[\u0300-\u036f]'), '');

  return normalized;
}

Future<void> shareTextWithFiles({String? text, List<String>? fileUrls}) async {
  try {
    final tempDir = await getTemporaryDirectory();
    List<XFile> filesToShare = [];
    if (fileUrls != null)
      for (String url in fileUrls) {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode != 200) {
          print('Failed to download: $url');
          continue;
        }

        final fileName = url.split('/').last;
        final filePath = '${tempDir.path}/$fileName';
        final mimeType = lookupMimeType(fileName) ?? 'application/octet-stream';

        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        filesToShare.add(XFile(filePath, mimeType: mimeType));
      }

    if (filesToShare.isNotEmpty) {
      await Share.shareXFiles(
        filesToShare,
        text: text,
      );
    } else {
      print('No files downloaded successfully.');
      await Share.share(text ?? "myapp");
    }
  } catch (e) {
    print('Error sharing files: $e');
  }
}

Future<void> shareTextWithByteFile(
    {required Uint8List bytes, required String fileName, String? text}) async {
  try {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');

    await file.writeAsBytes(bytes);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: text,
    );
  } catch (e) {
    print('Error sharing file: $e');
  }
}

Future<void> openPDF(context, Uint8List pdfData) async {
  loadingDialog(context);
  await Printing.layoutPdf(onLayout: (format) async => pdfData).then((_) {
    Navigator.of(context).pop();
  });
}

Future<DateTime?> pickDateTime(
  BuildContext context, {
  bool withTime = true,
  bool past = true,
  bool today = true,
  bool future = true,
}) async {
  final now = DateTime.now();
  DateTime firstDate;
  DateTime lastDate;

  if (past && future) {
    firstDate = DateTime(2000);
    lastDate = DateTime(2100);
  } else if (past && today && !future) {
    firstDate = DateTime(2000);
    lastDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
  } else if (!past && today && future) {
    firstDate = DateTime(now.year, now.month, now.day);
    lastDate = DateTime(2100);
  } else if (today && !past && !future) {
    firstDate = DateTime(now.year, now.month, now.day);
    lastDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
  } else {
    // No valid dates allowed
    return null;
  }

  final DateTime? date = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (date == null) return null;

  if (!withTime) return date;

  final TimeOfDay? time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (time == null) return date;

  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}

String convertAmountToWords(double amount) {
  final units = [
    "",
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
    "Eleven",
    "Twelve",
    "Thirteen",
    "Fourteen",
    "Fifteen",
    "Sixteen",
    "Seventeen",
    "Eighteen",
    "Nineteen"
  ];
  final tens = [
    "",
    "",
    "Twenty",
    "Thirty",
    "Forty",
    "Fifty",
    "Sixty",
    "Seventy",
    "Eighty",
    "Ninety"
  ];

  String twoDigitToWords(int n) {
    if (n < 20) return units[n];
    return tens[n ~/ 10] + (n % 10 != 0 ? " ${units[n % 10]}" : "");
  }

  // String threeDigitToWords(int n) {
  //   if (n == 0) return "";
  //   if (n < 100) return twoDigitToWords(n);
  //   return "${units[n ~/ 100]} Hundred${n % 100 != 0 ? " ${twoDigitToWords(n % 100)}" : ""}";
  // }

  String numberToWords(int n) {
    if (n == 0) return "Zero";
    String result = "";
    if ((n ~/ 10000000) > 0) {
      result += "${numberToWords(n ~/ 10000000)} Crore ";
      n %= 10000000;
    }
    if ((n ~/ 100000) > 0) {
      result += "${numberToWords(n ~/ 100000)} Lakh ";
      n %= 100000;
    }
    if ((n ~/ 1000) > 0) {
      result += "${numberToWords(n ~/ 1000)} Thousand ";
      n %= 1000;
    }
    if ((n ~/ 100) > 0) {
      result += "${units[n ~/ 100]} Hundred ";
      n %= 100;
    }
    if (n > 0) {
      if (result.isNotEmpty) result += "and ";
      result += twoDigitToWords(n);
    }
    return result.trim();
  }

  int rupees = amount.floor();
  int paise = ((amount - rupees) * 100).round();

  String rupeesWords = numberToWords(rupees) + " Rupees";
  String paiseWords = paise > 0 ? " and ${numberToWords(paise)} Paise" : "";

  return "$rupeesWords$paiseWords";
}

// Future<void> setThemeDark(bool isDark)  async {
//   await Injection.appStorage.write(SecureStorageItem(key:Appstoragekeys.isThemeDark, value: isDark?"1":"0"));
// }
// Future<bool> getIsThemeDark()  async {
//   return await Injection.appStorage.read(Appstoragekeys.isThemeDark) == "1" ? true : false;
// }


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const LOGIN_ROLES = ["ADMIN", "CUSTOMER", "EMPLOYEE"];
const bool APP_TYPE_SUPER_ADMIN = true;

class Constants {
  // ignore: constant_identifier_names
  static bool IS_DARK_THEME = false;
  static const Color textColor = Color(0xFF3B2045);         // Dark purple (Text Color)
  static const Color buttonText = Color(0xFF7A3C00);        // Brownish-orange (Button text)
  static const Color buttonBackground = Color(0xFFFFC270);  // Light orange (Button Background)
  static const Color primary = Color(0xFFD07924);           // Orange (Primary)
  static const Color grey = Color(0xFF8B8075);              // Warm grey (Grey)
  static const Color orange= Color(0xFFFFF3E0);
  static const Color pinkbackground=Color(0xFFFDE7D4);
  static Color LIGHT_BLUE = Colors.blue;
  static Color get GREEN => Colors.green;
  static Color get SELECTED_BLUE => Colors.blue.shade100;
  static Color get LIGHT_GREY => Colors.grey.shade300;
  static Color get RED => Colors.red;
  static Color get DARK_BLUE => IS_DARK_THEME ? Colors.blue : Color(0xFF004AAD);
  static Color get WHITE => IS_DARK_THEME ? Colors.black : Colors.white;
  static Color get BLACK => IS_DARK_THEME ? Colors.white : Colors.black;
  static Color get BACKGROUND =>
      IS_DARK_THEME ? Color.fromARGB(255, 0, 18, 39) : Color(0xFFF5F5F5);
  static Color get PURPLE =>
      IS_DARK_THEME ? Color(0xFFF5F5F5) : Color(0xFF31356E);

//


  static String formatedDate({required DateTime date}) {
    return DateFormat('d MMM yyyy').format(date);
  }

  static String formatedDateTime({required DateTime date}) {
    return DateFormat('dd MMM yyyy h:mm a').format(date);
  }

  static String formatedTime({required DateTime date}) {
    return DateFormat('h:mm a').format(date);
  }

  static DateFormat dateTimeFormat = DateFormat("dd MMM yyyy hh:mm a");
  static DateFormat timeFormat = DateFormat("hh:mm a");
  static DateFormat dateFormat = DateFormat("dd-MM-yyyy");
}

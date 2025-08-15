import 'package:myapp/static/constants.dart';
import 'package:flutter/material.dart';

// Function to show a success SnackBar
void successMessage(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Constants.WHITE),
    ),
    backgroundColor: Colors.green,
    duration: Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// Function to show an error SnackBar
void errorMessage(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Constants.WHITE),
    ),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

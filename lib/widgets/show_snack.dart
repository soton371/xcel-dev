import 'package:flutter/material.dart';
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
void showSnack(String title) {
    final snackbar = SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 15, backgroundColor: Colors.green, color: Colors.white),
        ));
    scaffoldMessengerKey.currentState!.showSnackBar(snackbar);
  }
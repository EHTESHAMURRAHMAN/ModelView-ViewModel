import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMessage(String massage) {
    Fluttertoast.showToast(msg: massage, backgroundColor: Colors.red);
  }

  static void flushBarErrorMessage(
      String tmessage, String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          padding: EdgeInsets.all(15),
          message: message,
          title: tmessage,
          borderRadius: BorderRadius.circular(10),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.red,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: Icon(Icons.error, color: Colors.white, size: 28),
          duration: const Duration(seconds: 3),
        )..show(context));
  }

  static snackBar(String massge, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massge)));
  }
}

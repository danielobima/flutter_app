import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toaster {
  FToast fToast= FToast();
  showToast(String msg) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline),
          const SizedBox(
            width: 12.0,
          ),
          Text(msg),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
    );

    // Custom Toast Position

  }
}
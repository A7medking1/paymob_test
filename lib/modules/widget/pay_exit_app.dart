import 'package:flutter/material.dart';
import 'package:paymob_test/core/helper.dart';
import 'package:paymob_test/main.dart';

void paymentExitApp(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text(
          'Are you sure  completed the pay',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // context.pop();
              context.navigateAndFinish(const HomeScreen());
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );
}

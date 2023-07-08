import 'package:flutter/material.dart';
import 'package:paymob_test/core/constant.dart';

import 'package:paymob_test/modules/widget/pay_exit_app.dart';

class RefCodeScreen extends StatelessWidget {
  const RefCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reference Code'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              paymentExitApp(context);
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'You should go to any market to pay',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'This is reference code',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 30.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.purple.shade300,
                ),
                child: Center(
                  child: Text(
                    ApiConstant.refCode.isEmpty ? '🚫' : ApiConstant.refCode,
                    style: const TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

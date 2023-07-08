
import 'package:flutter/material.dart';

extension RouterHelper on BuildContext {
  void push(
      Widget widget,
      ) {
    Navigator.push(this, MaterialPageRoute(builder: (_) => widget));
  }


  void pop(){
    Navigator.of(this).pop();
  }

  void navigateAndFinish(widget) => Navigator.pushAndRemoveUntil(
    this,
    MaterialPageRoute(
      builder: (_) => widget,
    ),
        (route) => false,
  );
}
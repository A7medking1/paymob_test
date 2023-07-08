import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Widget widget;
  final void Function()? onPressed;

  final double width;
  final Color backgroundColor;
  final double radius;

  const DefaultButton({
    super.key,
    required this.widget,
    required this.onPressed,
    this.width = double.infinity,
    this.backgroundColor = Colors.blue,
    this.radius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: widget,
      ),
    );
  }
}

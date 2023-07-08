import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  final TextInputType? type;
  final String? hintText;
  final IconData? prefix;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final int? lengthCharacters;

  const CustomFormField({
    super.key,
    this.prefix,
    this.type,
    this.hintText,
    this.controller,
    this.validate,
    this.lengthCharacters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      inputFormatters: [
        LengthLimitingTextInputFormatter(lengthCharacters),
      ],
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          prefix,
          color: Colors.purple,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Colors.grey.shade500,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isobscure;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.icon,
      this.isobscure = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 20),
          prefixIcon: Icon(icon),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: borderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: borderColor))),
      obscureText: isobscure,
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final FocusNode focusNode;
  final bool? obscureText;

  final TextEditingController textEditingController;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.focusNode,
    required this.textEditingController,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.maxFinite,
      height: 60,
      decoration: BoxDecoration(
        color: Color.fromRGBO(214, 224, 239, 1),
        borderRadius: BorderRadius.circular(13),
      ),
      child: TextField(
        obscureText: obscureText!,
        focusNode: focusNode,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          suffixIcon: Icon(icon),
        ),
      ),
    );
  }
}

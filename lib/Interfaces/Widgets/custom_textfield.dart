import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.validator,
  }) : super(key: key);
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.grey[600]),
      child: Container(
        padding: const EdgeInsets.only(left: 5, top: 5),
        child: TextFormField(
          controller: controller,
          validator: validator,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              counterStyle: const TextStyle(color: Colors.transparent),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
              icon: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
              border: InputBorder.none),
        ),
      ),
    );
  }
}

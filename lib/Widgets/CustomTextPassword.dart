// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomPasswordTextFiled extends StatelessWidget {
  String? hintText;
  Function(String)? onChange;
  final TextEditingController myController;
  CustomPasswordTextFiled(
      {super.key, this.hintText, this.onChange, required this.myController,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        validator: (data) {
          if (data!.isEmpty) {
            return 'field is required';
          }
          return null;
        },
        controller: myController,
        onChanged: onChange,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 10,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 235, 235, 235),
            ),
          ),
        ),
      ),
    );
  }
}

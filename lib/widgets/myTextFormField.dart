import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
MyTextFormField({required this.controller,required this.hintText,this.maxLines=1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration:  InputDecoration(
          label: Text(
            hintText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        maxLines: maxLines,
      ),
    );
  }
}

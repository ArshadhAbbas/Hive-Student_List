import 'package:flutter/material.dart';

class WidgetProvider extends ChangeNotifier
{
   Widget textField({
    required TextEditingController fieldcontroller,
    int? maxLines,
    String? hintText,
    String? labelText,
    int? maxLength,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      maxLines: maxLines,
      controller: fieldcontroller,
      maxLength: maxLength,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Cannot be empty';
        } else {
          return null;
        }
      },
    );
  }
}
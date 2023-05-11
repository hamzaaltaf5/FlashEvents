import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool isPass;
  final TextInputType textInputType;
  final Icon icon;

  TextFieldInput({
    required this.hintText,
    this.isPass = false,
    required this.textEditingController,
    required this.textInputType,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
      borderRadius: BorderRadius.circular(10.0),
    );
    return TextFormField(
      // validator: ( value ) => _validateUsername(value),
      controller: textEditingController,
      keyboardType: textInputType,
      obscureText: isPass,
      decoration: InputDecoration(
        prefixIcon: icon,
        border: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        hintText: hintText,
        contentPadding: EdgeInsets.all(10.0),
      ),
    );
  }
}

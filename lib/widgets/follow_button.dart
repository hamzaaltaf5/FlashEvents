import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function()? function;
  Color? backgroundColor;
  Color borderColor;
  String? text;
  Color? textColor;

  CustomButton(
      {Key? key,
        this.function,
        this.backgroundColor,
        required this.borderColor,
        this.text,
        this.textColor,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor,)
          ),
          alignment: Alignment.center,
          child: Text(text!, style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
          ),
          width: 100,
          height: 27,
        ),
      ),
    );
  }
}

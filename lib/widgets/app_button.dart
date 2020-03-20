import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String text;
  Function onClick;

  AppButton(this.text, this.onClick);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        this.text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white
        ),
      ),
      color: Colors.red,
      onPressed: onClick,
    );
  }
}

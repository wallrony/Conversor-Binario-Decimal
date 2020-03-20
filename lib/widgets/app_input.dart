import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  String label;
  String hint;
  TextEditingController controller;

  AppInput(this.label, this.hint, this.controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      cursorColor: Colors.red,
      maxLength: 8,
      onChanged: (String text) {
        bool hasDiff = false;
        String validText = "";

        for(var i = 0 ; i < text.length; i++) {
          String caractere = text[i];

          if(caractere != '1' && caractere != '0') {
            hasDiff = true;
          }
          else {
            validText += text[i];
          }
        }

        if(hasDiff) {
          controller.text = validText;
        }
      },
      validator: (String text) {
        if(text.isEmpty) {
          return "Você precisa inserir um número binário!";
        }

        return null;
      },
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 18,
          color: Colors.grey,
        ),
        hoverColor: Colors.red,
        focusColor: Colors.redAccent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        )
      ),
    );
  }
}

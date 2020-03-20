import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:conversor_binario_decimal/blocs/home_bloc.dart';
import 'package:conversor_binario_decimal/widgets/app_button.dart';
import 'package:conversor_binario_decimal/widgets/app_input.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _binController = TextEditingController();
  final _homeBloc = HomeBloc();

  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bin2Decimal"),
        centerTitle: true,
      ),
      body: _body()
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: switchValue ? Colors.white : Colors.red
                          )
                      ),
                      child:  Text(
                        "Decimal",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      )
                  ),
                  StreamBuilder<bool>(
                      stream: _homeBloc.switchStream,
                      builder: (context, snapshot) {
                        return Switch(
                          onChanged: (bool value) {
                            _homeBloc.setSwitchStream = value;
                            setState(() => switchValue = value);
                          },
                          value: snapshot.data ?? false,
                        );
                      }
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: !switchValue ? Colors.white : Colors.red
                          )
                      ),
                      child:  Text(
                        "Caractere",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      )
                  )
                ]
              ),
            ),
            SizedBox(height: 10),
            AppInput(
                "Número Binário",
                "Insira o número binário",
                _binController
            ),
            AppButton("Converter", _onConvert),
            SizedBox(height: 10),
            StreamBuilder<String>(
              stream: _homeBloc.resultStream,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data != null ?
                  "Resultado: ${snapshot.data}"
                      :
                  "Esperando conversão...",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ]
        ),
      ),
    );
  }

  _onConvert() {
    bool formOk = _formKey.currentState.validate();

    if(!formOk) {
      return;
    }

    String bin = _binController.text;
    String reverseBin = "";
    double decimal = 0;

    for(var i = 0 ; i < bin.length; i++) {
      if(bin[i] == '1') {
        decimal += pow(2, bin.length - 1 - i);
      }
    }

    if(switchValue) {
      _homeBloc.setResultStream = String.fromCharCode(
        int.parse(decimal.toInt().toString())
      );

      print(String.fromCharCode(
          int.parse(decimal.toInt().toString()) + 255
      ));
    }
    else {
      _homeBloc.setResultStream = decimal.toInt().toString();
    }
  }
}

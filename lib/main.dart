import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.green,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.green),
          titleMedium: TextStyle(color: Colors.green),
          headlineMedium: TextStyle(color: Colors.green),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
      ),
      home: MyHomePage(title: 'Calculadora de IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _result = '';
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  double _calculateIMC() {
    final peso = double.parse(_pesoController.text);
    final altura = double.parse(_alturaController.text) / 100;

    return (peso / pow(altura, 2));
  }

  void _setStatus() {
    double imc = _calculateIMC();
    String status;

    if (imc < 18.5) {
      status = "Abaixo do peso - IMC:(${imc.toStringAsFixed(3)})";
    } else if (imc < 24.9) {
      status = "Peso normal - IMC:(${imc.toStringAsFixed(3)})";
    } else if (imc < 29.9) {
      status = "Pré-obesidade - IMC:(${imc.toStringAsFixed(3)})";
    } else if (imc < 34.9) {
      status = "Obesidade Grau I - IMC:(${imc.toStringAsFixed(3)})";
    } else if (imc < 39.9) {
      status = "Obesidade Grau II - IMC:(${imc.toStringAsFixed(3)})";
    } else {
      status = "Obesidade Grau III - IMC:(${imc.toStringAsFixed(3)})";
    }

    setState(() {
      _result = status;
    });
  }

  void _clear() {
    setState(() {
      _result = '';
      _pesoController.clear();
      _alturaController.clear();
    });
  }

  TextField getTextField(requiredController) {
    return TextField(
      controller: requiredController,
      style: TextStyle(color: Colors.green, fontSize: 18.0),
      textAlign: TextAlign.center,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*\.?[0-9]*$')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _clear),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.person_outlined,
                size: 100,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Text('Peso (kg):'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: getTextField(_pesoController),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Text('Altura (cm):'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: getTextField(_alturaController),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _setStatus,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    'Calcular',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
            ),
            if (_result.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Text(
                    _result,
                    style: TextStyle(color: Colors.green, fontSize: 18.0),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  double _result = 0.0;

  void _calculate(String operation) {
    final double num1 = double.tryParse(_num1Controller.text) ?? 0.0;
    final double num2 = double.tryParse(_num2Controller.text) ?? 0.0;

    setState(() {
      switch (operation) {
        case '+':
          _result = num1 + num2;
          break;
        case '-':
          _result = num1 - num2;
          break;
        case '*':
          _result = num1 * num2;
          break;
        case '/':
          _result = num2 != 0 ? num1 / num2 : 0.0;
          break;
      }
    });
  }

  void _clear() {
    setState(() {
      _num1Controller.clear();
      _num2Controller.clear();
      _result = 0.0;
    });
  }

  Widget _buildOperationButton(String operation) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton(
          onPressed: () => _calculate(operation),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[900], // Fondo azul oscuro
            foregroundColor: Colors.white, // Texto blanco
          ),
          child: Text(
            operation,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        onPressed: _clear,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[900], // Fondo azul oscuro
          foregroundColor: Colors.white, // Texto blanco
        ),
        child: const Text(
          'Limpiar',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Flutter'),
      ),
      body: Stack(
        children: <Widget>[
          // Imagen de fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/fondo.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido de la calculadora
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo
              Container(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  'assets/logo.jpeg', // Asegúrate de tener un logo en la carpeta assets
                  width: 1000, // Ajusta el ancho del logo
                  height: 150, // Ajusta la altura del logo
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              // Input para número 1
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _num1Controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Número 1',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Input para número 2
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _num2Controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Número 2',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Caja de resultado
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: Text(
                  'Resultado [N/A]: $_result',
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              // Botones de operaciones
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    _buildOperationButton('+'),
                    _buildOperationButton('-'),
                    _buildOperationButton('*'),
                    _buildOperationButton('/'),
                  ],
                ),
              ),
              // Botón de limpiar
              _buildClearButton(),
              const SizedBox(height: 20),
              // Texto de derechos reservados
              const Text(
                'Todos los derechos reservados © Alexis Uranga 2023',
                style: TextStyle(color: Colors.black, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

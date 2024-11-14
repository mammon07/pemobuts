import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  String _currentOperand = "";
  double _firstNumber = 0;
  String _operation = "";

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _firstNumber = 0;
        _operation = "";
        _currentOperand = "";
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        _firstNumber = double.parse(_currentOperand);
        _operation = value;
        _currentOperand = "";
      } else if (value == "=") {
        double secondNumber = double.parse(_currentOperand);
        switch (_operation) {
          case "+":
            _output = (_firstNumber + secondNumber).toString();
            break;
          case "-":
            _output = (_firstNumber - secondNumber).toString();
            break;
          case "*":
            _output = (_firstNumber * secondNumber).toString();
            break;
          case "/":
            _output = secondNumber != 0 ? (_firstNumber / secondNumber).toString() : "Error";
            break;
        }
        _firstNumber = 0;
        _operation = "";
        _currentOperand = _output;
      } else {
        if (_currentOperand == "0") {
          _currentOperand = value;
        } else {
          _currentOperand += value;
        }
        _output = _currentOperand;
      }
    });
  }

  Widget _buildButton(String label, {bool isOperator = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: isOperator ? Color(0xFF90D4D6) : Color(0xFFB9E5E8),
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            alignment: Alignment.centerRight,
            child: Text(
              _output,
              style: TextStyle(fontSize: 48, color: Colors.white),
            ),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("/", isOperator: true),
            ],
          ),
          Row(
            children: [
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("*", isOperator: true),
            ],
          ),
          Row(
            children: [
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("-", isOperator: true),
            ],
          ),
          Row(
            children: [
              _buildButton("0"),
              _buildButton("."),
              _buildButton("C"),
              _buildButton("+", isOperator: true),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () => _buttonPressed("="),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1D1E1F),
                      padding: EdgeInsets.all(20),
                    ),
                    child: Text(
                      "=",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

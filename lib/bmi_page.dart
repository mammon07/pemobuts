import 'package:flutter/material.dart';

class BmiPage extends StatefulWidget {
  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  double _height = 0; // Tinggi dalam cm
  double _weight = 0; // Berat dalam kg
  String _bmiResult = '';
  String _bmiCategory = '';

  void _calculateBMI() {
    if (_height > 0 && _weight > 0) {
      double heightInMeters = _height / 100;
      double bmi = _weight / (heightInMeters * heightInMeters);
      setState(() {
        _bmiResult = 'BMI Anda: ${bmi.toStringAsFixed(2)}';
        _bmiCategory = _getBmiCategory(bmi);
      });
    } else {
      setState(() {
        _bmiResult = 'Masukkan tinggi dan berat yang valid.';
        _bmiCategory = '';
      });
    }
  }

  String _getBmiCategory(double bmi) {
    if (bmi < 18.5) {
      return 'Kurus';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Gemuk';
    } else {
      return 'Obesitas';
    }
  }

  double _getBmiProgress(double bmi) {
    if (bmi < 18.5) return bmi / 18.5;
    if (bmi >= 18.5 && bmi < 24.9) return (bmi - 18.5) / (24.9 - 18.5);
    if (bmi >= 25 && bmi < 29.9) return (bmi - 25) / (29.9 - 25);
    return 1.0; // Maksimal untuk obesitas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildInputField('Tinggi (cm)', (value) {
                setState(() {
                  _height = double.tryParse(value) ?? 0;
                });
              }),
              SizedBox(height: 20),
              _buildInputField('Berat (kg)', (value) {
                setState(() {
                  _weight = double.tryParse(value) ?? 0;
                });
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB9E5E8),
                  minimumSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Sudut membulat
                  ),
                ),
                child: Text(
                  'Hitung BMI',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                _bmiResult,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              if (_bmiCategory.isNotEmpty)
                Column(
                  children: [
                    Text(
                      _bmiCategory,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: _getBmiProgress(double.tryParse(_bmiResult.split(' ')[2]) ?? 0),
                      backgroundColor: Colors.grey[800],
                      color: Colors.blueAccent,
                      minHeight: 10,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, Function(String) onChanged) {
    return TextField(
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        fillColor: Colors.black,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}

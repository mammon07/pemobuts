import 'package:flutter/material.dart';

class ConversionContent extends StatefulWidget {
  @override
  _ConversionContentState createState() => _ConversionContentState();
}

class _ConversionContentState extends State<ConversionContent> {
  String _selectedConversionType = '';
  String _selectedConversionOption = '';
  double _inputValue = 0;
  double _discountValue = 0; // Variabel untuk nilai diskon
  String _outputValue = '';

  final Map<String, List<String>> _conversionOptions = {
    'Suhu': ['Celsius ke Fahrenheit', 'Fahrenheit ke Celsius'],
    'Mata Uang': ['USD ke IDR', 'IDR ke USD'],
    'Ukuran': ['Meter ke Inci', 'Inci ke Meter'],
    'Kecepatan': ['Km/h ke Mph', 'Mph ke Km/h'],
    'Usia': ['Hari ke Tahun', 'Tahun ke Hari'],
    'Diskon': ['Harga Setelah Diskon', 'Diskon dari Harga'],
    'Waktu': ['Jam ke Menit', 'Menit ke Jam'],
  };

  void _convert() {
    String resultWithUnit = '';

    switch (_selectedConversionOption) {
      case 'Celsius ke Fahrenheit':
        resultWithUnit = '${(_inputValue * 9 / 5) + 32} °F';
        break;
      case 'Fahrenheit ke Celsius':
        resultWithUnit = '${(_inputValue - 32) * 5 / 9} °C';
        break;
      case 'Meter ke Inci':
        resultWithUnit = '${_inputValue * 39.37} inch';
        break;
      case 'Inci ke Meter':
        resultWithUnit = '${_inputValue / 39.37} m';
        break;
      case 'USD ke IDR':
        resultWithUnit = '${_inputValue * 14500} IDR'; // Sample conversion rate
        break;
      case 'IDR ke USD':
        resultWithUnit = '${_inputValue / 14500} USD';
        break;
      case 'Harga Setelah Diskon':
        resultWithUnit = '${_inputValue - (_inputValue * (_discountValue / 100))} (Setelah Diskon)';
        break;
      case 'Diskon dari Harga':
        resultWithUnit = '${_inputValue * (_discountValue / 100)} (Diskon)';
        break;
      case 'Hari ke Tahun':
        resultWithUnit = '${_inputValue / 365.25} Tahun';
        break;
      case 'Tahun ke Hari':
        resultWithUnit = '${_inputValue * 365.25} Hari';
        break;
      case 'Km/h ke Mph':
        resultWithUnit = '${_inputValue * 0.621371} mph';
        break;
      case 'Mph ke Km/h':
        resultWithUnit = '${_inputValue / 0.621371} km/h';
        break;
      case 'Jam ke Menit':
        resultWithUnit = '${_inputValue * 60} Menit';
        break;
      case 'Menit ke Jam':
        resultWithUnit = '${_inputValue / 60} Jam';
        break;
      default:
        resultWithUnit = 'Invalid Option';
    }

    setState(() {
      _outputValue = resultWithUnit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color set to black
      body: Center( // Center the content vertically and horizontally
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: _conversionOptions.keys.map((type) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 16), // Margin yang lebih besar untuk menurunkan tombol
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedConversionType = type;
                        _selectedConversionOption = '';
                        _outputValue = '';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedConversionType == type
                          ? Colors.blueAccent
                          : Color(0xFFB9E5E8),
                      padding: EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: Icon(_getIconForType(type), color: Colors.black),
                    label: Text(
                      type,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (_selectedConversionType == type)
                  ...[
                    DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('Pilih Konversi', style: TextStyle(color: Colors.white, fontSize: 18)),
                      value: _selectedConversionOption.isEmpty ? null : _selectedConversionOption,
                      dropdownColor: Colors.grey[800], // Dark grey background for the dropdown
                      items: _conversionOptions[type]!
                          .map((option) => DropdownMenuItem(
                                value: option,
                                child: Text(option, style: TextStyle(color: Colors.white, fontSize: 18)), // White text
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedConversionOption = value!;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    if (_selectedConversionOption.isNotEmpty) ...[
                      _buildInputField('Masukkan nilai untuk dikonversi'),
                      if (_selectedConversionOption == 'Harga Setelah Diskon' || _selectedConversionOption == 'Diskon dari Harga') ...[
                        _buildDiscountField('Masukkan Diskon (%)'),
                      ],
                      SizedBox(height: 20),
                      Center( // Center the button horizontally
                        child: ElevatedButton(
                          onPressed: _convert,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800], // Dark gray color for the button
                            minimumSize: Size(200, 50), // Fixed button size
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero, // Sharp corners
                            ),
                          ),
                          child: Text(
                            'Konversi',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        _outputValue,
                        style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ],
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildInputField(String label) {
    return TextField(
      onChanged: (value) {
        setState(() {
          _inputValue = double.tryParse(value) ?? 0;
        });
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]), // Gray label color
        fillColor: Colors.black, // Black background for text field
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[600]), // Hint text color
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // White border color
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // White border when focused
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // White border when enabled
        ),
      ),
      style: TextStyle(color: Colors.white), // White text color for input
    );
  }

  Widget _buildDiscountField(String label) {
    return TextField(
      onChanged: (value) {
        setState(() {
          _discountValue = double.tryParse(value) ?? 0;
        });
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]), // Gray label color
        fillColor: Colors.black, // Black background for text field
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[600]), // Hint text color
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // White border color
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // White border when focused
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // White border when enabled
        ),
      ),
      style: TextStyle(color: Colors.white), // White text color for input
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'Suhu':
        return Icons.thermostat_outlined;
      case 'Mata Uang':
        return Icons.monetization_on_outlined;
      case 'Ukuran':
        return Icons.expand_more;
      case 'Kecepatan':
        return Icons.speed;
      case 'Usia':
        return Icons.access_time;
      case 'Diskon':
        return Icons.discount_outlined;
      case 'Waktu':
        return Icons.timer;
      default:
        return Icons.help_outline;
    }
  }
}

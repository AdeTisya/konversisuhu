import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _fahrenheitController = TextEditingController();
  final TextEditingController _celsiusController = TextEditingController();
  final TextEditingController _reamurController = TextEditingController();
  final TextEditingController _kelvinController = TextEditingController();

  final FocusNode _fahrenheitFocus = FocusNode();
  final FocusNode _celsiusFocus = FocusNode();
  final FocusNode _reamurFocus = FocusNode();
  final FocusNode _kelvinFocus = FocusNode();

  void _updateValues(String value, String unit) {
    double? input = double.tryParse(value);
    if (input == null) return;

    setState(() {
      if (_fahrenheitFocus.hasFocus) {
        _celsiusController.text = ((input - 32) * 5 / 9).toStringAsFixed(2);
        _reamurController.text = ((input - 32) * 4 / 9).toStringAsFixed(2);
        _kelvinController.text = ((input - 32) * 5 / 9 + 273.15).toStringAsFixed(2);
      } else if (_celsiusFocus.hasFocus) {
        _fahrenheitController.text = ((input * 9 / 5) + 32).toStringAsFixed(2);
        _reamurController.text = (input * 4 / 5).toStringAsFixed(2);
        _kelvinController.text = (input + 273.15).toStringAsFixed(2);
      } else if (_reamurFocus.hasFocus) {
        _fahrenheitController.text = ((input * 9 / 4) + 32).toStringAsFixed(2);
        _celsiusController.text = (input * 5 / 4).toStringAsFixed(2);
        _kelvinController.text = ((input * 5 / 4) + 273.15).toStringAsFixed(2);
      } else if (_kelvinFocus.hasFocus) {
        _fahrenheitController.text = ((input - 273.15) * 9 / 5 + 32).toStringAsFixed(2);
        _celsiusController.text = (input - 273.15).toStringAsFixed(2);
        _reamurController.text = ((input - 273.15) * 4 / 5).toStringAsFixed(2);
      }
    });
  }

  Widget _buildTemperatureField(String label, TextEditingController controller, FocusNode focusNode, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[-0-9.]+'))],
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIcon: Icon(Icons.thermostat, color: Colors.orangeAccent),
        ),
        onChanged: (value) => _updateValues(value, unit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Suhu', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.orange[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTemperatureField('Fahrenheit', _fahrenheitController, _fahrenheitFocus, 'F'),
            _buildTemperatureField('Celsius', _celsiusController, _celsiusFocus, 'C'),
            _buildTemperatureField('Reamur', _reamurController, _reamurFocus, 'R'),
            _buildTemperatureField('Kelvin', _kelvinController, _kelvinFocus, 'K'),
          ],
        ),
      ),
    );
  }
}

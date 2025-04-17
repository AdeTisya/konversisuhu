import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'temperature_provider.dart';

class TemperatureConverter extends StatelessWidget {
  final TextEditingController _fahrenheitController = TextEditingController();
  final TextEditingController _celsiusController = TextEditingController();
  final TextEditingController _reamurController = TextEditingController();
  final TextEditingController _kelvinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tempProvider = Provider.of<TemperatureProvider>(context);

    // Set value ke controller biar selalu sinkron
    _fahrenheitController.text = tempProvider.fahrenheit.toStringAsFixed(2);
    _celsiusController.text = tempProvider.celsius.toStringAsFixed(2);
    _reamurController.text = tempProvider.reamur.toStringAsFixed(2);
    _kelvinController.text = tempProvider.kelvin.toStringAsFixed(2);

    Widget _buildField(String label, TextEditingController controller, String unit) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[-0-9.]+'))],
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            prefixIcon: Icon(Icons.thermostat, color: Colors.orange),
          ),
          onTap: () => controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length),
          onSubmitted: (value) => tempProvider.updateFrom(value, unit),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Suhu', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.orange[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildField('Fahrenheit', _fahrenheitController, 'F'),
            _buildField('Celsius', _celsiusController, 'C'),
            _buildField('Reamur', _reamurController, 'R'),
            _buildField('Kelvin', _kelvinController, 'K'),
          ],
        ),
      ),
    );
  }
}

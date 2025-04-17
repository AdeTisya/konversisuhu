import 'package:flutter/material.dart';

class TemperatureProvider with ChangeNotifier {
  double fahrenheit = 0;
  double celsius = 0;
  double reamur = 0;
  double kelvin = 0;

  void updateFrom(String value, String unit) {
    double? input = double.tryParse(value);
    if (input == null) return;

    switch (unit) {
      case 'F':
        fahrenheit = input;
        celsius = (input - 32) * 5 / 9;
        reamur = (input - 32) * 4 / 9;
        kelvin = (input - 32) * 5 / 9 + 273.15;
        break;
      case 'C':
        celsius = input;
        fahrenheit = (input * 9 / 5) + 32;
        reamur = input * 4 / 5;
        kelvin = input + 273.15;
        break;
      case 'R':
        reamur = input;
        celsius = input * 5 / 4;
        fahrenheit = (input * 9 / 4) + 32;
        kelvin = (input * 5 / 4) + 273.15;
        break;
      case 'K':
        kelvin = input;
        celsius = input - 273.15;
        fahrenheit = (celsius * 9 / 5) + 32;
        reamur = celsius * 4 / 5;
        break;
    }

    notifyListeners();
  }
}

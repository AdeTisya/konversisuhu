import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Login.dart';
import 'temperature_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TemperatureProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konversi Suhu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyLoginPage(),
    );
  }
}

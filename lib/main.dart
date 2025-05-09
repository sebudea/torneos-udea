import 'package:flutter/material.dart';
import 'package:torneos_udea/constants/app_constants.dart';
import 'package:torneos_udea/ui/views/menu/menu_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.name,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MenuView(),
    );
  }
}

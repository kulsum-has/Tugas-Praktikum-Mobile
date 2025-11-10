import 'package:flutter/material.dart';
import 'package:tugas5/screen/Homepage.dart';

void main() {
  runApp(const MyApp()); // Ditambahkan const untuk performa
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Malas Ngoding Menu', // Tambahkan title
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const HalamanUtama(), // Ditambahkan const
    );
  }
}
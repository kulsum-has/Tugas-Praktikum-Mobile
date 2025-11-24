import 'package:flutter/material.dart';
import 'package:tugas7/models/keranjang.dart';
import 'package:tugas7/screens/halamanbarang.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Keranjang(), //memberitahu kelas mana yang akan ada perubahannya
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Provider',
      home: HalamanBarang(),
      debugShowCheckedModeBanner: false,
    );
  }
}
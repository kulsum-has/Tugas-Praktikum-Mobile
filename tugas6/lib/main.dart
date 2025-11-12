import 'package:flutter/material.dart';
import 'package:tugas6/pages/Homepage.dart'; // Import Halaman Utama

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Wisata',
      theme: ThemeData(
        // Style: Menggunakan warna Teal sebagai seedColor
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), 
        useMaterial3: true,
      ),
      home: const Homepage(), // Mengarahkan ke Homepage yang sudah dimodifikasi
    );
  }
}

// Hapus kelas MyHomePage dan _MyHomePageState karena tidak digunakan lagi
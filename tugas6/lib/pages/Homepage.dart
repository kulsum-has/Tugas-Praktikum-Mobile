import 'package:flutter/material.dart';
import 'package:tugas6/widget/list.dart';
import 'package:tugas6/widget/grid.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil warna tema
    final primaryColor = Theme.of(context).colorScheme.primary;

    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Katalog Wisata Indonesia'),
          backgroundColor: primaryColor, // Style: Warna AppBar sesuai tema
          foregroundColor: Colors.white, // Style: Warna teks dan icon putih
          elevation: 8, // Style: Bayangan AppBar
          bottom: TabBar(
            indicatorColor: Colors.white, // Style: Garis indikator putih
            labelColor: Colors.white, // Style: Warna label saat aktif putih
            unselectedLabelColor: Colors.white70, // Style: Warna label saat tidak aktif
            labelStyle: const TextStyle(fontWeight: FontWeight.bold), 
            tabs: const [
              Tab(icon: Icon(Icons.list_alt_outlined), text: 'Daftar Lokasi'),
              Tab(icon: Icon(Icons.grid_on), text: 'Galeri Grid'),
            ]),
        ),
        body: TabBarView(
          children: [
            buildlistview(), // Menampilkan List View
            buildgridview(), // Menampilkan Grid View
          ]
        ),
      )
    );
  }
}
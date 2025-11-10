import 'package:flutter/material.dart';

class Halamandetail extends StatelessWidget {
  final String menu;
  final String harga;
  final String deskripsi; // Tambahkan deskripsi
  final String gambar; // Tambahkan gambar

  const Halamandetail({
    super.key,
    required this.menu,
    required this.harga,
    required this.deskripsi,
    required this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menu),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan Gambar
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(gambar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            // Nama Menu
            Text(
              menu,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            // Harga
            Text(
              harga,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            const Divider(height: 30, thickness: 1),

            // Deskripsi
            const Text(
              "Deskripsi Produk:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              deskripsi,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
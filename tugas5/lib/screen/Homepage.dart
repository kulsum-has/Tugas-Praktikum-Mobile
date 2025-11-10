import 'package:flutter/material.dart';
import 'package:tugas5/model/makanan.dart';
import 'package:tugas5/screen/halamandetail.dart';

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    var menus = Makanan();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Menu Makanan"),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: menus.menu.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4, // Menambahkan sedikit bayangan
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Halamandetail(
                      menu: menus.menu[index],
                      harga: menus.harga[index],
                      deskripsi: menus.deskripsi[index], // Kirim deskripsi
                      gambar: menus.gambar[index], // Kirim URL gambar
                    ),
                  ),
                );
              },
              child: ListTile(
                // Menggunakan CircleAvatar dengan gambar
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(menus.gambar[index]),
                  radius: 28,
                ),
                // Judul Menu
                title: Text(
                  menus.menu[index],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // Subtitle (Harga dan Deskripsi)
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menus.harga[index],
                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      menus.deskripsi[index],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis, // Memotong deskripsi jika terlalu panjang
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.amber,
                  size: 16,
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
          );
        },
      ),
    );
  }
}
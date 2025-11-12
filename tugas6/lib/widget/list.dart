import 'package:flutter/material.dart';
import 'package:tugas6/model/travel.dart';
import 'package:tugas6/pages/DetailPage.dart'; // Import Halaman Detail

var data = Travel();

Widget buildlistview() {
  return ListView.builder(
    itemCount: data.travelData.length,
    itemBuilder: (context, index) {
      var item = data.travelData[index];
      return Card(
        elevation: 5, // Style: Bayangan Card
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Style: Rounded Corner
        child: InkWell( // Widget yang membuat card bisa diklik
          onTap: () {
            // Navigasi ke halaman DetailPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(travelItem: item),
              ),
            );
          },
          child: ListTile(
            contentPadding: const EdgeInsets.all(10.0), 
            leading: ClipRRect( // Style: Gambar Rounded
              borderRadius: BorderRadius.circular(8.0),
              child: Hero(
                tag: item['title']!,
                child: Image.network(
                  item['image']!,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              item['title']!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), // Style: Judul Bold
            ),
            subtitle: Text(
              item['description']!.split('.')[0], // Menampilkan kalimat pertama deskripsi
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(
              Icons.chevron_right, 
              color: Theme.of(context).colorScheme.primary, // Style: Icon warna tema
            ),
          ),
        ),
      );
    },
  );
}
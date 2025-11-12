import 'package:flutter/material.dart';
import 'package:tugas6/model/travel.dart';
import 'package:tugas6/pages/DetailPage.dart'; // Import Halaman Detail

var data = Travel();

Widget buildgridview() {
  return GridView.builder(
    padding: const EdgeInsets.all(10), 
    itemCount: data.travelData.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.75, // Style: Mengatur rasio agar gambar dan teks terlihat baik
    ),
    itemBuilder: (context, index) {
      var item = data.travelData[index];
      return Card(
        elevation: 6, // Style: Bayangan Card yang lebih jelas
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Style: Sudut Card membulat
        clipBehavior: Clip.antiAlias, // Memastikan konten terpotong sesuai bentuk card
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Hero(
                  tag: item['title']!,
                  child: Image.network(
                    item['image']!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item['title']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
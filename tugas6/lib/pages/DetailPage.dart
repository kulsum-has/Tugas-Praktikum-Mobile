import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, String> travelItem;

  const DetailPage({super.key, required this.travelItem});

  @override
  Widget build(BuildContext context) {
    // Menggunakan warna tema utama dari MaterialApp
    final primaryColor = Theme.of(context).colorScheme.primary;
    final headlineStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: primaryColor,
    );
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(travelItem['title']!),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // **Style Menarik: Hero Animation dan Image**
            Hero(
              tag: travelItem['title']!, // Tag untuk transisi animasi
              child: Image.network(
                travelItem['image']!,
                fit: BoxFit.cover,
                height: 280,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 280,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // **Style Menarik: Judul dengan warna tema**
                  Text(
                    travelItem['title']!,
                    style: headlineStyle,
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  const SizedBox(height: 15),
                  
                  Text(
                    'Deskripsi Lokasi:',
                    style: titleStyle,
                  ),
                  const SizedBox(height: 10),
                  
                  // **Style Menarik: Kotak informasi dengan elevated card**
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        travelItem['description']!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // **Style Menarik: Chip untuk tag**
                  Row(
                    children: [
                      Chip(
                        label: const Text('Wisata Alam'),
                        backgroundColor: primaryColor.withOpacity(0.1),
                        labelStyle: TextStyle(color: primaryColor),
                        avatar: Icon(Icons.nature, color: primaryColor, size: 18),
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: const Text('Wajib Dikunjungi'),
                        backgroundColor: Colors.orange.withOpacity(0.1),
                        labelStyle: const TextStyle(color: Colors.orange),
                        avatar: const Icon(Icons.star, color: Colors.orange, size: 18),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
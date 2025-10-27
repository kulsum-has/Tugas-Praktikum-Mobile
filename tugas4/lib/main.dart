import 'package:flutter/material.dart';
import 'package:tugas4/Model/ApiService.dart';

void main() {
  runApp(Appberita());
}

class Appberita extends StatelessWidget {
  const Appberita({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Mengubah judul aplikasi untuk memperjelas
      title: 'Aplikasi Berita Kategori Makanan', 
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TampilanBerita(),
    );
  }
}

class TampilanBerita extends StatefulWidget {
  const TampilanBerita({super.key});

  @override
  State<TampilanBerita> createState() => _TampilanBeritaState();
}

class _TampilanBeritaState extends State<TampilanBerita> {
  // Deklarasi ScrollController untuk mengontrol ListView
  final ScrollController _scrollController = ScrollController();
  
  late Future<List<Artikel>> _articlesFuture;
  
  // State untuk mengontrol visibilitas tombol Scroll-to-Top
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi future untuk pertama kali
    _articlesFuture = Apiservice().fetchArticles();
    
    // 1. Inisialisasi listener untuk ScrollController
    _scrollController.addListener(_scrollListener);
  }

  // Listener untuk memeriksa posisi scroll
  void _scrollListener() {
    // Tampilkan tombol jika posisi scroll lebih dari 400 pixel
    if (_scrollController.offset >= 400 && !_showBackToTopButton) {
      setState(() {
        _showBackToTopButton = true;
      });
    } else if (_scrollController.offset < 400 && _showBackToTopButton) {
      setState(() {
        _showBackToTopButton = false;
      });
    }
  }

  // 1. Fungsi untuk memuat ulang data (dipanggil oleh pull-to-refresh)
  Future<void> _refreshArticles() async {
    setState(() {
      // Mengganti _articlesFuture dengan panggilan API baru
      _articlesFuture = Apiservice().fetchArticles();
    });
  }

  // 2. Fungsi untuk menggulir ke atas
  void _scrollToTop() {
    _scrollController.animateTo(
      0, // Posisi paling atas
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    // Membersihkan controller dan listener saat widget dihapus
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategori Menu"),
        backgroundColor: Colors.blueGrey, // Mengubah warna AppBar
      ),
      // 1. Menggunakan RefreshIndicator untuk pull-to-refresh
      body: RefreshIndicator(
        onRefresh: _refreshArticles, // Panggil fungsi refresh
        child: FutureBuilder<List<Artikel>>(
          future: _articlesFuture,
          builder: (context, snapshot) {
            
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else if(snapshot.hasError){
              return Center(
                child: Text("Error : ${snapshot.error}"),
                );
            }else if(snapshot.hasData && snapshot.data!.isNotEmpty){
              final article = snapshot.data!;
              
              return ListView.builder(
                // 2. Menerapkan ScrollController ke ListView
                controller: _scrollController, 
                itemCount: article.length,
                itemBuilder: (context, index) {
                  final berita = article[index];
                  return Card(
                    elevation: 2, // Menambahkan elevasi pada Card
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                        child: ListTile(
                          // Menggunakan BoxFit.cover pada gambar
                          leading: berita.gambar != null 
                            ? Image.network(
                                berita.gambar!, 
                                width: 80, 
                                height: 80, 
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image), // Handle error gambar
                              ) 
                            : const Icon(Icons.image_not_supported),
                          title: Text(
                            berita.kategori,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            berita.deskripsi!,
                            maxLines: 3, // Batasi jumlah baris deskripsi
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Tambahkan onTap jika ingin membuat item bisa diklik
                        ),
                      ),
                  );
                },
              );
            }else{
              // Pesan jika tidak ada data, dibungkus dalam ListView agar pull-to-refresh tetap berfungsi
              return ListView(
                children: const [
                  Center(
                    heightFactor: 10,
                    child: Text("Tidak ada berita yang ditemukan."),
                  ),
                ],
              );
            }
          } ,
        ),
      ),
      // 2. FloatingActionButton untuk Scroll-to-Top
      floatingActionButton: _showBackToTopButton 
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: Colors.blueGrey,
              tooltip: 'Kembali ke atas',
              child: const Icon(Icons.arrow_upward),
            ) 
          : null, // Hilangkan tombol jika tidak perlu
    );
  }
}
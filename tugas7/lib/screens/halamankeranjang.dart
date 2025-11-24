import 'package:flutter/material.dart';
import 'package:tugas7/models/keranjang.dart';
import 'package:provider/provider.dart';

class HalamanKeranjang extends StatelessWidget {
  const HalamanKeranjang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Kamu'),
        backgroundColor: const Color.fromARGB(100, 20, 100, 98),
      ),
      body: Consumer<Keranjang>(
        builder: (context, value, child) {
          if (value.isiKeranjang.isEmpty){
            return const Center(child: Text('Keranjang Kosong'),);
          }
          return ListView.builder(
            itemCount: value.isiKeranjang.length,
            itemBuilder: (context, index) {
              final item = value.isiKeranjang[index];
              return ListTile(
               title: Text(value.isiKeranjang[index].nama),
                trailing: IconButton(
                onPressed: () {
                  Provider.of<Keranjang>(context, listen: false).hapus(value.isiKeranjang[index]);
                },
                icon: Icon(Icons.remove),
              ),
             );
            },
          );
        },
      ),
    );
  }
}
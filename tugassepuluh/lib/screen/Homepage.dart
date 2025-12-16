import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final tugas = TextEditingController();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  void tambahtugas() {
    final user = auth.currentUser;
    // kondisi ada akun dan data tidak kosong
    if (user != null && tugas.text.isNotEmpty) {
      firestore.collection('users').doc(user.uid).collection('TodoList').add({
        'Tugas': tugas.text,
        'CreateAt': Timestamp.now(),
        'isCompleted': false, // <--- TAMBAHAN: Field baru untuk status selesai
      });
      tugas.clear();
    }
  }

  // <--- FUNGSI BARU: Untuk mengubah status isCompleted
  void toggleSelesai(String docId, bool? currentValue) {
    final user = auth.currentUser;
    if (user != null) {
      firestore
          .collection('users')
          .doc(user.uid)
          .collection('TodoList')
          .doc(docId)
          .update({
        // Mengubah status menjadi kebalikannya
        'isCompleted': !currentValue!, 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Beranda"),
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('users')
                  .doc(user.uid)
                  .collection('TodoList')
                  .orderBy('CreateAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("data kosong"));
                }

                final doc = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: doc.length,
                  itemBuilder: (context, index) {
                    final data = doc[index].data() as Map<String, dynamic>;
                    final bool isSelesai = data['isCompleted'] ?? false; // Ambil status, default false
                    final String docId = doc[index].id;

                    return Card(
                      child: CheckboxListTile( // <--- PERUBAHAN UTAMA: Gunakan CheckboxListTile
                        title: Text(
                          data['Tugas'],
                          style: TextStyle(
                            // Tambahkan dekorasi garis jika sudah selesai
                            decoration: isSelesai ? TextDecoration.lineThrough : null, 
                            color: isSelesai ? Colors.grey : Colors.black,
                          ),
                        ),
                        value: isSelesai,
                        onChanged: (newValue) {
                          // Panggil fungsi toggleSelesai saat checkbox diklik
                          toggleSelesai(docId, newValue); 
                        },
                        secondary: IconButton( // Icon Hapus dijadikan 'secondary'
                          onPressed: () => doc[index].reference.delete(),
                          icon: Icon(Icons.delete_forever),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: tugas,
                    decoration: InputDecoration(labelText: "Masukan tugas"),
                  ),
                ),

                IconButton(onPressed: tambahtugas, icon: Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
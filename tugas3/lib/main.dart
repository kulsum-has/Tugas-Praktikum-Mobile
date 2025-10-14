import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk input numerik

void main() {
  runApp(kalkulatorBMI());
}

// ----------------------------------------------------
// 1. Root Widget dan Tema (diperbarui untuk tema cute)
// ----------------------------------------------------

class kalkulatorBMI extends StatelessWidget {
  const kalkulatorBMI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Mengatur tema menjadi pink soft yang cute
      theme: ThemeData(
        primarySwatch: Colors.pink,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.pinkAccent.shade100),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8BBD0), // Soft Pink
          foregroundColor: Colors.black87,
        ),
      ),
      home: const Tampilankalkulatorbmi(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ----------------------------------------------------
// 2. State Widget untuk Tampilan
// ----------------------------------------------------

class Tampilankalkulatorbmi extends StatefulWidget {
  const Tampilankalkulatorbmi({super.key});

  @override
  State<Tampilankalkulatorbmi> createState() => _TampilankalkulatorbmiState();
}

class _TampilankalkulatorbmiState extends State<Tampilankalkulatorbmi> {
  // Controllers untuk input teks
  final _beratcontroller = TextEditingController();
  final _tinggicontroller = TextEditingController();

  // Variabel state untuk hasil
  double? _hasilbmi;
  String _komentar = "Masukkan Nilai";
  // Variabel baru untuk Jenis Kelamin (Requirement 3)
  String _jenisKelamin = 'Pria'; // Default

  // Fungsi untuk menghitung BMI (diperbarui dengan logika gender)
  void hasil() {
    final double berat = double.tryParse(_beratcontroller.text) ?? 0;
    final double tinggiInCm = double.tryParse(_tinggicontroller.text) ?? 0;

    setState(() {
      if (berat > 0 && tinggiInCm > 0) {
        final double tinggiInM = tinggiInCm / 100;
        final double bmi = berat / (tinggiInM * tinggiInM);
        _hasilbmi = bmi;

        // Logika BMI berdasarkan Jenis Kelamin (Requirement 3)
        if (_jenisKelamin == 'Pria') {
          // Kategori BMI untuk Pria
          if (bmi < 18.5) {
            _komentar = "Cowok Ceking! Makan yang banyak dan sehat ya.";
          } else if (bmi < 24.5) {
            _komentar = "Anjayy Macho! Bentuk badan ideal. Pertahankan!";
          } else if (bmi < 30) {
            _komentar = "Aduh Bro, mulai kegendutan nih. Yuk olahraga!";
          } else {
            _komentar = "Obesitas Bro! AYO DIETT KETAT!";
          }
        } else if (_jenisKelamin == 'Wanita') {
          // Kategori BMI untuk Wanita
          if (bmi < 18.5) {
            _komentar = "Cewek Ceking! Butuh nutrisi nih. Jangan skip makan.";
          } else if (bmi < 25) {
            _komentar = "Anjayy Langsing! Bentuk badan ideal. Super cute!";
          } else if (bmi < 30) {
            _komentar = "Aduh Sis, mulai kegendutan nih. Semangat diet sehat!";
          } else {
            _komentar = "Obesitas Sis! AYO DIETT KETATTT!";
          }
        }
      } else {
        _komentar = "Masukkan Data yang valid (Angka > 0)";
        _hasilbmi = null;
      }
    });
  }

  // Fungsi untuk me-reset data (Requirement 1)
  void resetData() {
    setState(() {
      _beratcontroller.clear();
      _tinggicontroller.clear();
      _hasilbmi = null;
      _komentar = "Masukkan Nilai";
      _jenisKelamin = 'Pria'; // Reset juga jenis kelamin ke default
    });
  }

  @override
  void dispose() {
    _beratcontroller.dispose();
    _tinggicontroller.dispose();
    super.dispose();
  }

  // ----------------------------------------------------
  // 3. Tampilan UI (diperbarui dengan styling dan reset button)
  // ----------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kalkulator BMI",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0), // Padding di sekeliling
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Input Berat Badan
            const Text("Berat Badan (Kg)",
                style: TextStyle(fontSize: 16, color: Colors.pink)),
            const SizedBox(height: 8),
            TextField(
              controller: _beratcontroller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              decoration: InputDecoration(
                labelText: "0",
                hintStyle: TextStyle(color: Colors.pink.shade200),
                prefixIcon: const Icon(Icons.scale, color: Colors.pinkAccent), // Icon (Requirement 2)
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.pink),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.pink, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Input Tinggi Badan
            const Text("Tinggi Badan (Cm)",
                style: TextStyle(fontSize: 16, color: Colors.pink)),
            const SizedBox(height: 8),
            TextField(
              controller: _tinggicontroller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              decoration: InputDecoration(
                labelText: "0",
                hintStyle: TextStyle(color: Colors.pink.shade200),
                prefixIcon: const Icon(Icons.height, color: Colors.pinkAccent), // Icon (Requirement 2)
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.pink),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.pink, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Pilihan Jenis Kelamin (Requirement 3)
            const Text("Jenis Kelamin",
                style: TextStyle(fontSize: 16, color: Colors.pink)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Radio Pria
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Pria'),
                    value: 'Pria',
                    groupValue: _jenisKelamin,
                    onChanged: (String? value) {
                      setState(() {
                        _jenisKelamin = value!;
                        _hasilbmi = null; // Clear result on gender change
                        _komentar = "Pilih 'Hitung BMI' lagi";
                      });
                    },
                    activeColor: Colors.pink,
                  ),
                ),
                // Radio Wanita
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Wanita'),
                    value: 'Wanita',
                    groupValue: _jenisKelamin,
                    onChanged: (String? value) {
                      setState(() {
                        _jenisKelamin = value!;
                        _hasilbmi = null; // Clear result on gender change
                        _komentar = "Pilih 'Hitung BMI' lagi";
                      });
                    },
                    activeColor: Colors.pink,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tombol Hitung dan Reset
            Row(
              children: [
                // Tombol Hitung BMI
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: hasil,
                    icon: const Icon(Icons.calculate), // Icon (Requirement 2)
                    label: const Text("Hitung BMI"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink, // Soft Pink
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Tombol Reset (Requirement 1)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: resetData,
                    icon: const Icon(Icons.refresh), // Icon (Requirement 2)
                    label: const Text("Reset"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade200, // Lighter Pink
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Area Hasil Perhitungan
            const Center(
                child: Text("HASIL",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink))),
            const Divider(color: Colors.pinkAccent),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.pink.shade50, // Background soft
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    _hasilbmi?.toStringAsFixed(1) ?? "--",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _komentar,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: (_hasilbmi == null || _hasilbmi! < 18.5)
                          ? Colors.blue
                          : (_hasilbmi! < 25
                              ? Colors.green
                              : (_hasilbmi! < 30 ? Colors.orange : Colors.red)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

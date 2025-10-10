import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class kartu extends StatelessWidget {
  const kartu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //materialapp untuk luaran
      title: "Kartu Identitas",
      home: TampilanKartu(),
    );
  }
}

class TampilanKartu extends StatelessWidget {
  const TampilanKartu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 146, 185),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                  'https://png.pngtree.com/png-clipart/20210808/original/pngtree-cartoon-islamic-muslim-girl-png-image_6617044.jpg',
                ),
                
              ),
              Text(
                  "Kultsum",
                style: GoogleFonts.pacifico(
                  fontSize: 40,
                  color : Colors.white,
                  fontWeight: FontWeight.bold),
                  
                ),
                Text(
                  "Mahasiswi & Programer",
                  style: GoogleFonts.sourceSans3(
                  fontSize: 20,
                  color : Colors.teal.shade100,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold
                  )
                ),

                SizedBox(
                  height: 20,
                  width: 200,
                  child: Divider(color: Colors.teal.shade100),
                ),

                Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(Icons.phone, 
                    color: Colors.teal.shade900,
                    ),
                    title: Text("08123456789",
                    style: TextStyle(
                      color: Colors.teal.shade900),
                    ),
                    ),
                  ),
                  Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(Icons.email, 
                    color: Colors.teal.shade900,
                    ),
                    title: Text("hasniumukulsum@gmail.com",
                    style: TextStyle(
                      color: Colors.teal.shade900),
                    ),
                    ),
                  ),
                  Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(Icons.camera_alt, 
                    color: Colors.teal.shade900,
                    ),
                    title: Text("klsm394_",
                    style: TextStyle(
                      color: Colors.teal.shade900),
                    ),
                    ),
                  ),

                  Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(Icons.tiktok, 
                    color: Colors.teal.shade900,
                    ),
                    title: Text("klsm394_",
                    style: TextStyle(
                      color: Colors.teal.shade900),
                    ),
                    ),
                  ),


                
        
            ],
          ),
        ),
      ),
    );
  }
}
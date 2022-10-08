import 'package:flutter/material.dart';


class Validasi extends StatefulWidget {
  const Validasi({super.key});

  @override
  State<Validasi> createState() => _ValidasiState();
}

class _ValidasiState extends State<Validasi> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 32, 138, 76),
      body: Padding(
        padding: EdgeInsets.only(top: 250, left: 15, right: 15),
        child: Container(
          width: (MediaQuery.of(context).size.width),
          height: 225,
          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'Validasi Akun!',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                  fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Data Anda dalam tahap verifikasi admin, silahkan tunggu',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300,
                  fontSize: 16),
                ),
              ),
              Container(
                height: 50,
                width: (MediaQuery.of(context).size.width)-100,
                child: ElevatedButton(
                  child: Text('Log Out', ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 249, 56, 43),
                    shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(100))
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
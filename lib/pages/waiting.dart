import 'package:flutter/material.dart';
import 'package:my_final/pages/master.dart';

class Validasi extends StatefulWidget {
  const Validasi({super.key});

  @override
  State<Validasi> createState() => _ValidasiState();
}

class _ValidasiState extends State<Validasi> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xFF3A9854).withOpacity(0.9),
      body: Padding(
        padding: EdgeInsets.only(top: 250, left: 25, right: 25),
        child: Container(
          width: (MediaQuery.of(context).size.width),
          height: 225,
          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(6))
                        ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                // Container(
                //   height: 40,
                //   // width: (MediaQuery.of(context).size.width)-100,
                //   child: ElevatedButton(
                //     child: Text('Log Out', ),
                //     style: ElevatedButton.styleFrom(
                //       primary: Color(0xFFD11919),
                //       shape: RoundedRectangleBorder(
                //                     borderRadius: new BorderRadius.circular(100))
                //     ),
                //     onPressed: () {},
                //   ),
                // ),
                GestureDetector(
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                            color: Color(0xFFD11919),
                            borderRadius: BorderRadius.all(Radius.circular(6))
                          ),
                    child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            Container(width: 10,),
                            Icon(Icons.logout, color: Colors.white,)
                          ],
                        ),
                  ),
                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const MyMaster()),
                                    );
                                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
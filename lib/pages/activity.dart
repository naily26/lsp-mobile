import 'package:flutter/material.dart';
import 'package:my_final/data/my_colors.dart';
import 'package:my_final/widget/my_text.dart';
import 'package:my_final/pages/apl01.dart';
import 'package:my_final/pages/apl02.dart';
import 'package:my_final/pages/jadwal.dart';
import 'package:my_final/pages/hasil.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
   @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Activity'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(height: 30),
            Text("Your Activity", style: MyText.medium(context).copyWith(color: MyColors.grey_90, fontWeight: FontWeight.bold)),
            Container(height: 10),
            Row(
              children: <Widget>[
                Container(width: 15),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Apl01Page()),
                        );
                      },
                    child: Container( padding: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: MyColors.grey_5,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.file_copy, size: 35, color: Color.fromARGB(255, 14, 111, 16)),
                            Container(height: 18),
                            Text("APL-01", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90)),
                          ],
                      ),
                    ),
                  ),
                ),
                Container(width: 6),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Apl02Page()),
                        );
                      },
                    child: Container( padding: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: MyColors.grey_5,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.book, size: 35, color: Color.fromARGB(255, 14, 111, 16)),
                          Container(height: 18),
                          Text("APL-02", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90)),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 6),
                Expanded(
                  child:GestureDetector(
                    onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const JadwalPage()),
                        );
                      },
                    child: Container( padding: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: MyColors.grey_5,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.event, size: 35, color: Color.fromARGB(255, 14, 111, 16)),
                          Container(height: 18),
                          Text("JADWAL", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90)),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 15),
              ],
            ),
            Container(height: 6),
            Row(
              children: <Widget>[
                Container(width: 15),
                Expanded(
                  child: Container( padding: EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: MyColors.grey_5,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.my_library_books_rounded, size: 35, color: Color.fromARGB(255, 14, 111, 16)),
                        Container(height: 18),
                        Text("MATERI", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90)),
                      ],
                    ),
                  ),
                ),
                Container(width: 6),
                Expanded(
                  child: GestureDetector(
                     onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HasilPage()),
                        );
                      },
                    child: Container( padding: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: MyColors.grey_5,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.check_box, size: 35, color: Color.fromARGB(255, 14, 111, 16)),
                          Container(height: 18),
                          Text("HASIL", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90)),
                        ],
                      ),
                    ),
                  ),
                ),
                // Container(width: 6),
                // Expanded(
                //   child: Container( padding: EdgeInsets.symmetric(vertical: 20),
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: MyColors.grey_5,
                //       borderRadius: BorderRadius.all(Radius.circular(4)),
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: <Widget>[
                //         Icon(Icons.public, size: 35, color: Colors.indigo[500]),
                //         Container(height: 18),
                //         Text("INTERNET", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90)),
                //       ],
                //     ),
                //   ),
                // ),
                Container(width: 15),
              ],
            ),],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:my_final/data/img.dart';
import 'package:my_final/data/my_colors.dart';
import 'package:my_final/widget/my_text.dart';

class HasilPage extends StatefulWidget {
  const HasilPage({super.key});

  @override
  State<HasilPage> createState() => _HasilPageState();
}

class _HasilPageState extends State<HasilPage> {
   @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Hasil Uji Kompetensi'),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                color: Color.fromARGB(255, 14, 111, 16),
                width: double.infinity, height: 270,
                // child: Image.asset(Img.get('world_map.png'),fit: BoxFit.cover),
              )
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                
                // Padding(
                //   padding: const EdgeInsets.only(top: 60),
                //   child: Text("APL-01", style: MyText.headline(context)!.copyWith(color: Colors.white)),
                // ),
                Container(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.asset('assets/banner12.jpg')
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 55, left: 15),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Selamat!',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                              )
                            ),
                          ),
                        ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(1)),
                  color: Colors.white, elevation: 2,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Text("Sertifikat", style: MyText.body2(context)!.copyWith(color: MyColors.grey_40)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: <Widget>[
                             Row(
                              children: <Widget>[
                                Icon(Icons.text_snippet_outlined, color: MyColors.grey_40),
                                Container(width: 10),
                                Text("sertifikat.pdf", style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            
                            Container(width: double.infinity, height: 1, color: MyColors.grey_20)
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Text("Info", style: MyText.body2(context)!.copyWith(color: MyColors.grey_40)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: <Widget>[
                             Row(
                              children: <Widget>[
                                Icon(Icons.book, color: MyColors.grey_40),
                                Container(width: 10),
                                Text("Pemograman Mobile", style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              children: <Widget>[
                                Icon(Icons.event, color: MyColors.grey_40),
                                Container(width: 10),
                                Text("11-02-2022", style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              children: <Widget>[
                                Icon(Icons.person, color: MyColors.grey_40),
                                Container(width: 10),
                                Text("Sehun M.T", style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              children: <Widget>[
                                Icon(Icons.location_city, color: MyColors.grey_40),
                                Container(width: 10),
                                Text("Gedung 3C", style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Container(width: double.infinity, height: 1, color: MyColors.grey_20)
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Text("Status", style: MyText.body2(context)!.copyWith(color: MyColors.grey_40)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.layers, color: MyColors.grey_40),
                                Container(width: 10),
                                Text("Kompeten", style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                          ],
                        ),
                      ),
                      Container(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
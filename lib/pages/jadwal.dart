import 'package:flutter/material.dart';
import 'package:my_final/data/img.dart';
import 'package:my_final/data/my_colors.dart';
import 'package:my_final/widget/my_text.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
   @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Jadwal Assesment'),
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
                        child: Text("Dokumen", style: MyText.body2(context)!.copyWith(color: MyColors.grey_40)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.text_snippet_outlined, color: MyColors.grey_40),
                                Container(width: 10),
                                Text("dokumen-apl-01.pdf", style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                             Row(
                              children: <Widget>[
                                Icon(Icons.text_snippet_outlined, color: MyColors.grey_40),
                                Container(width: 10),
                                Text("dokumen-apl-02.pdf", style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
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
                                Text("Asessment dilanjutkan", style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
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
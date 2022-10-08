import 'package:flutter/material.dart';
import 'package:my_final/data/img.dart';
import 'package:my_final/data/my_colors.dart';
import 'package:my_final/widget/my_text.dart';

class Apl02Page extends StatefulWidget {
  const Apl02Page({super.key});

  @override
  State<Apl02Page> createState() => _Apl02PageState();
}

class _Apl02PageState extends State<Apl02Page> {
   @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('APL-02'),
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
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Text(
                            'Template dokumen APL sudah tersedia, silahkan download, isi, dan upload kembali.',
                             style: MyText.body2(context)!.copyWith(color: MyColors.grey_60)
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.text_snippet_outlined,
                                  color: Colors.black,
                                  size: 21.0,
                                ),
                                Text('dokumen.pdf',
                                  style: MyText.body2(context)!.copyWith(color: MyColors.grey_60)
                                ),
                                Container(width: 10,),
                                Container(
                                  height: 28,
                                  child: ElevatedButton(
                                    child: Text('Upload Apl-02', style: TextStyle(fontSize: 12)),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[900],
                                      shape: RoundedRectangleBorder(
                                                    borderRadius: new BorderRadius.circular(4))
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
                Container(height: 5),
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
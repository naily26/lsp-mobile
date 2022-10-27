import 'package:flutter/material.dart';
import 'package:my_final/data/img.dart';
import 'package:my_final/data/my_colors.dart';
import 'package:my_final/widget/my_text.dart';
import 'package:my_final/pages/view-pdf.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  var AsesiId;
  var _data;
  var nama_skema;
  final String _tokenAuth = '';
  var UserId;
  String status_apl_02 = '';
  var file_apl_02;
  var file_apl_01;
  String tanggal_assesment = '';
  String tuk = '';
  String asesor = '';
  String lokasi = '';
  String PenanggungJawab = '';

  Future _getAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nama_skema = prefs.getString('nama_skema');
    UserId = prefs.getInt('UserId');
    AsesiId = prefs.getInt('AsesiId');
    try {
      var url = Uri.parse('https://lsp.intermediatech.id/api/get_data_pengajuan/' + AsesiId.toString());
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ' + _tokenAuth},
      );
      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body)['data'];
        });
        file_apl_02 = _data['file_apl_02'];
        file_apl_01 = _data['file_apl_01'];
        var status = _data['status_apl_02'].toString();
        tanggal_assesment = _data['tanggal_assesment'].toString();
        asesor = _data['asesor']['name'].toString();
        PenanggungJawab = _data['tuk']['penanggung_jawab'].toString();
        tuk = _data['tuk']['name'].toString();
        lokasi = _data['tuk']['lokasi'].toString();
        print(_data['file_apl_01']);
      } else {
        print('error');
      }
    } on SocketException {
      print('no internet');
    } on HttpException {
      print('error');
    } on FormatException {
      print('error');
    }
  }

    @override
  void initState() {
    super.initState();
    _getAllData().whenComplete(() {
      setState(() {});
    });
  }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                 GestureDetector(
                                        onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => PdfPage(link: file_apl_01, title: 'File Apl-01',)),
                                      );
                                    },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(color: Color.fromARGB(255, 13, 71, 161))
                                                  )),
                                          child: Text("dokumen-apl-01.pdf",
                                              style: MyText.body2(context)!
                                                  .copyWith(
                                                      color: Color.fromARGB(255, 13, 71, 161))),
                                        ),
                                      )
                              ],
                            ),
                            Container(height: 10),
                             Row(
                              children: <Widget>[
                                Icon(Icons.text_snippet_outlined, color: MyColors.grey_40),
                                Container(width: 10),
                                 GestureDetector(
                                        onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => PdfPage(link: file_apl_02, title: 'File Apl-02',)),
                                      );
                                    },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(color: Color.fromARGB(255, 13, 71, 161))
                                                  )),
                                          child: Text("dokumen-apl-02.pdf",
                                              style: MyText.body2(context)!
                                                  .copyWith(
                                                      color: Color.fromARGB(255, 13, 71, 161))),
                                        ),
                                      )
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
                                Text(nama_skema.toString(), style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              children: <Widget>[
                                Icon(Icons.person, color: MyColors.grey_40),
                                Container(width: 10),
                                Text(asesor, style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
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
                        child: Text("Waktu dan Tempat", style: MyText.body2(context)!.copyWith(color: MyColors.grey_40)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.event, color: MyColors.grey_40),
                                Container(width: 10),
                                Text(tanggal_assesment, style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              children: <Widget>[
                                Icon(Icons.assignment_ind, color: MyColors.grey_40),
                                Container(width: 10),
                                Text(PenanggungJawab, style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              children: <Widget>[
                                Icon(Icons.place, color: MyColors.grey_40),
                                Container(width: 10),
                                Text(tuk, style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              children: <Widget>[
                                Icon(Icons.location_city, color: MyColors.grey_40),
                                Container(width: 10),
                                Text(lokasi, style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
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
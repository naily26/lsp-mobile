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

class HasilPage extends StatefulWidget {
  const HasilPage({super.key});

  @override
  State<HasilPage> createState() => _HasilPageState();
}

class _HasilPageState extends State<HasilPage> {
  var AsesiId;
  var _data;
  var nama_skema;
  final String _tokenAuth = '';
  var UserId;
  String status_apl_02 = '';
  var file_apl_02;
  String tanggal_assesment = '';
  String tuk = '';
  String hasil = '';
  String asesor = '';
  String lokasi = '';
  String berita_acara = '';
  String sertifikat = '';

  Future _getAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nama_skema = prefs.getString('nama_skema');
    UserId = prefs.getInt('UserId');
    AsesiId = prefs.getInt('AsesiId');
    try {
      var url = Uri.parse(
          'https://lsp.intermediatech.id/api/get_data_pengajuan/' +
              AsesiId.toString());
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ' + _tokenAuth},
      );
      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body)['data'];
        });
        file_apl_02 = _data['file_apl_02'];
        var status = _data['status_apl_02'].toString();
        tanggal_assesment = _data['tanggal_assesment'].toString();
        hasil = _data['status_skema'].toString();
        asesor = _data['asesor']['name'].toString();
        tuk = _data['tuk']['name'].toString();
        lokasi = _data['tuk']['lokasi'].toString();
        berita_acara = _data['berita_acara'].toString();
        sertifikat = _data['sertifikat'].toString();
        print(sertifikat);
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
                Container(height: 25),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset('assets/banner12.jpg')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35, left: 15),
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  hasil == 'kompeten'
                                      ? 'Selamat! \nAnda lolos sertifikasi'
                                      : 'Mohon maaf! \nanda tidak lolos sertifikasi',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                )),
                            (sertifikat == 'null' && hasil == 'kompeten'
                                ? Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Sertifikat belum tersedia, silahkan tunggu!',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ))
                                : Container())
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1)),
                  color: Colors.white,
                  elevation: 2,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Text("Sertifikat dan Berita acara",
                            style: MyText.body2(context)!
                                .copyWith(color: MyColors.grey_40)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.text_snippet_outlined,
                                    color: MyColors.grey_40),
                                Container(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PdfPage(
                                                link: berita_acara,
                                                title: 'Berita acara',
                                              )),
                                    );
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 13, 71, 161)))),
                                    child: Text("berita-acara.pdf",
                                        style: MyText.body2(context)!.copyWith(
                                            color: Color.fromARGB(
                                                255, 13, 71, 161))),
                                  ),
                                )
                              ],
                            ),
                            Container(height: 10),
                            (sertifikat != 'null'
                                ? Row(
                                    children: <Widget>[
                                      Icon(Icons.text_snippet_outlined,
                                          color: MyColors.grey_40),
                                      Container(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => PdfPage(
                                                      link: sertifikat,
                                                      title: 'Sertifikat',
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 13, 71, 161)))),
                                          child: Text("sertifikat.pdf",
                                              style: MyText.body2(context)!
                                                  .copyWith(
                                                      color: Color.fromARGB(
                                                          255, 13, 71, 161))),
                                        ),
                                      )
                                    ],
                                  )
                                : Container()),
                            Container(
                                width: double.infinity,
                                height: 1,
                                color: MyColors.grey_20)
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Text("Info",
                            style: MyText.body2(context)!
                                .copyWith(color: MyColors.grey_40)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.book, color: MyColors.grey_40),
                                Container(width: 10),
                                Text(nama_skema.toString(),
                                    style: MyText.body2(context)!
                                        .copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              children: <Widget>[
                                Icon(Icons.person, color: MyColors.grey_40),
                                Container(width: 10),
                                Text(asesor,
                                    style: MyText.body2(context)!
                                        .copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Container(
                                width: double.infinity,
                                height: 1,
                                color: MyColors.grey_20)
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Text("Waktu dan Tempat",
                            style: MyText.body2(context)!
                                .copyWith(color: MyColors.grey_40)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.event, color: MyColors.grey_40),
                                Container(width: 10),
                                Text(tanggal_assesment,
                                    style: MyText.body2(context)!
                                        .copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              children: <Widget>[
                                Icon(Icons.place, color: MyColors.grey_40),
                                Container(width: 10),
                                Text(tuk,
                                    style: MyText.body2(context)!
                                        .copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              children: <Widget>[
                                Icon(Icons.location_city,
                                    color: MyColors.grey_40),
                                Container(width: 10),
                                Text(lokasi,
                                    style: MyText.body2(context)!
                                        .copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Container(
                                width: double.infinity,
                                height: 1,
                                color: MyColors.grey_20)
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Text("Status",
                            style: MyText.body2(context)!
                                .copyWith(color: MyColors.grey_40)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.layers, color: MyColors.grey_40),
                                Container(width: 10),
                                Text(hasil,
                                    style: MyText.body2(context)!
                                        .copyWith(color: MyColors.grey_60))
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

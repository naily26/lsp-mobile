import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_final/data/my_colors.dart';
import 'package:my_final/widget/my_text.dart';
import 'package:my_final/pages/activity/apl01.dart';
import 'package:my_final/pages/upload-apl01.dart';
import 'package:my_final/pages/activity/apl02.dart';
import 'package:my_final/pages/activity/jadwal.dart';
import 'package:my_final/pages/activity/hasil.dart';
import 'package:my_final/pages/view-pdf.dart';
import 'package:auto_size_text/auto_size_text.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  var _data;
  var _dataMateri;
  final String _tokenAuth = '';

  var UserId;
  var AsesiId;
  var file_apl_01;
  var file_apl_02;
  String apl_01 = '';
  var tanggal_assesment;
  var hasil;
  String linkMateri = '';
  String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

  String RecentText = 'belum ada aktivitas';

  Future _getAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserId = prefs.getInt('UserId');
    AsesiId = prefs.getInt('AsesiId');
    print(AsesiId);
    
  }

  Future _getDataPengajuan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
       
         postData(_data['status_apl_01'], _data['surat_tugas'], _data['tanggal_assesment'], _data['status_apl_02'],  _data['berita_acara'], _data['sertifikat'], _data['status_skema'],
          _data['kompetensi']['nama_skema'], _data['file_apl_01'], _data['file_apl_02']);
          apl_01 = _data['status_apl_01'].toString();
          tanggal_assesment = _data['tanggal_assesment'];
          hasil = _data['status_skema'];
          _getDataMateri(_data['kompetensi']['id'].toString());
      } else {
        print('error1');
      }
    } on SocketException {
      print('no internet');
    } on HttpException {
      print('error2');
    } on FormatException {
      print('error3');
    }
  }

   Future _getRecentActivity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserId = prefs.getInt('UserId');
    AsesiId = prefs.getInt('AsesiId');
    try {
      var url = Uri.parse('https://lsp.intermediatech.id/api/get_recent_activity/' + AsesiId.toString());
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ' + _tokenAuth},
      );
      if (response.statusCode == 200) {
        setState(() {
          var hasil = json.decode(response.body)['result'].toString();
          if (hasil != null ) {
            RecentText = hasil;
          }
        });
        print(RecentText);
      } else {
        print('error1');
      }
    } on SocketException {
      print('no internet');
    } on HttpException {
      print('error2');
    } on FormatException {
      print('error3');
    }
  }

  Future _getTemplate() async {
    try {
      var url = Uri.parse('https://lsp.intermediatech.id/api/get_dokumen');
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ' + _tokenAuth},
      );
      if (response.statusCode == 200) {
        setState(() {
          var dataRes = json.decode(response.body)['data'];
          postDataTemplate(dataRes['file_apl_01'], dataRes['file_apl_02']);
        });
      } else {
        print('error1');
      }
    } on SocketException {
      print('no internet');
    } on HttpException {
      print('error2');
    } on FormatException {
      print('error3');
    }
  }

  Future _getDataMateri(String kompetensiId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserId = prefs.getInt('UserId');
    AsesiId = prefs.getInt('AsesiId');
    try {
      var url = Uri.parse('https://lsp.intermediatech.id/api/get_detail_kompetensi/' + kompetensiId);
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ' + _tokenAuth},
      );
      if (response.statusCode == 200) {
        setState(() {
          _dataMateri = json.decode(response.body)['result'];
        });
        linkMateri = _dataMateri['materi']['dokumen_materi'].toString();
        print(linkMateri);
        print('sukses');
          
      } else {
        print('error1');
      }
    } on SocketException {
      print('no internet');
    } on HttpException {
      print('error2');
    } on FormatException {
      print('error3');
    }
  }

  Future postData(status_apl_01, surat_tugas, tanggal_assesment, status_apl_02, berita_acara, sertifikat, status_skema, nama_skema, file_apl_01, file_apl_02) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nama_skema', nama_skema);
    prefs.setString('file_apl_01', file_apl_01);
    prefs.setString('status_apl_01', status_apl_01 );
    prefs.setString('file_apl_02', file_apl_02);
    prefs.setString('tanggal_assesment', tanggal_assesment);
    prefs.setString('berita_acara', berita_acara);
    prefs.setString('status_skema', status_skema);
    prefs.setString('sertifikat', sertifikat);
    
  }

  Future postDataTemplate(tmp_apl_01, tmp_apl_02) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tmp_apl_01', tmp_apl_01);
    prefs.setString('tmp_apl_02', tmp_apl_02);
  }

  void _showToastNotAllowed(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(
          msg,
        ),
        action: SnackBarAction(
            label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Pertama Kali widget dijalankan memanggil request
    _getRecentActivity();
    _getAllData();
    _getDataPengajuan();
    _getTemplate();
  }



   @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
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
                          MaterialPageRoute(builder: (context) =>  PdfPage(link: linkMateri, title: 'Materi',)),
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
                          Icon(Icons.my_library_books_rounded, size: 35, color: Color.fromARGB(255, 14, 111, 16)),
                          Container(height: 18),
                          Text("MATERI", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90)),
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
                          MaterialPageRoute(builder: (context) =>  const Apl01Page()),
                        );
                        
                      },
                    child: Container( padding: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      decoration: const BoxDecoration(
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
                        if(apl_01 == 'continue') {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Apl02Page()),
                        );
                        } else {
                          _showToastNotAllowed(context, 'Silahkan menunggu persetujuan APL-01');
                        }
                        
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
                          (apl_01 == 'continue' ?
                          Icon(Icons.book, size: 35,  color: Color.fromARGB(255, 14, 111, 16))
                          : 
                          Icon(Icons.book, size: 35,  color: Colors.grey)),
                          Container(height: 18),
                          Text("APL-02", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90)),
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
                  child:GestureDetector(
                    onTap: () {
                      tanggal_assesment != null ?
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const JadwalPage()),
                        )
                        :
                        _showToastNotAllowed(context, 'Jadwal belum ditentukan');
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
                          (tanggal_assesment != null ?
                          Icon(Icons.event, size: 35,  color: Color.fromARGB(255, 14, 111, 16))
                          : 
                          Icon(Icons.event, size: 35,  color: Colors.grey)),
                          Container(height: 18),
                          Text("JADWAL", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90)),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 6),
                Expanded(
                  child: GestureDetector(
                     onTap: () {
                        hasil!= null ?
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HasilPage()),
                        )
                        :
                        _showToastNotAllowed(context, 'Belum ada hasil uji kompetensi');
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
                          (hasil != null ?
                          Icon(Icons.check_box, size: 35,  color: Color.fromARGB(255, 14, 111, 16))
                          : 
                          Icon(Icons.check_box, size: 35,  color: Colors.grey)),
                          Container(height: 18),
                          Text("HASIL", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90)),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 15),
              ],
            ),
            Container(height: 30),
            Text("Recent Activity", style: MyText.medium(context).copyWith(color: MyColors.grey_90, fontWeight: FontWeight.bold)),
            Container(height: 10),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 15),
               child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      color: MyColors.grey_5, elevation: 2, clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: MyColors.grey_10, child: Icon(Icons.arrow_upward_outlined, color: Color.fromARGB(255, 14, 111, 16), size: 17),
                            ),
                            Container(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // AutoSizeText(RecentText.toString(), maxLines: 2, style: MyText.subhead(context)!.copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14)),
                                Container(width: (MediaQuery.of(context).size.width) - 120, child: Text(RecentText, overflow: TextOverflow.visible, style: MyText.subhead(context)!.copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14))),
                                Container(height: 5),
                                Text(now.toString(), style: MyText.caption(context)!.copyWith(color: MyColors.grey_40)),
                              ],
                            ),
                            
                          ],
                        ),
                      ),
                    ),
             ),
            ],
        ),
      ),
    );
  }
}
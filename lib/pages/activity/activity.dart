import 'package:flutter/material.dart';
import 'package:my_final/data/my_colors.dart';
import 'package:my_final/widget/my_text.dart';
import 'package:my_final/pages/activity/apl01.dart';
import 'package:my_final/pages/upload-apl01.dart';
import 'package:my_final/pages/activity/apl02.dart';
import 'package:my_final/pages/activity/jadwal.dart';
import 'package:my_final/pages/activity/hasil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  var _data;
  final String _tokenAuth = '';

  var UserId;
  var AsesiId;
  var file_apl_01;
  var file_apl_02;
  String apl_01 = '';

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
          //  print(_data);
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

  Future postData(status_apl_01, surat_tugas, tanggal_assesment, status_apl_02, berita_acara, sertifikat, status_skema, nama_skema, file_apl_01, file_apl_02) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nama_skema', nama_skema);
    prefs.setString('file_apl_01', file_apl_01);
    prefs.setString('status_apl_01', status_apl_01 );
    prefs.setString('file_apl_02', file_apl_02);
    prefs.setString('surat_tugas', surat_tugas);
    prefs.setString('tanggal_assesment', tanggal_assesment);
    prefs.setString('status_apl_02', status_apl_02);
    prefs.setString('berita_acara', berita_acara);
    prefs.setString('sertifikat', sertifikat);
    prefs.setString('status_skema', status_skema);
  }

  void _showToastNotAllowed(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text(
          'Silahkan menunggu persetujuan APL-01',
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
    
    _getAllData();
    _getDataPengajuan();
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
                          _showToastNotAllowed(context);
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
                Container(width: 15),
              ],
            ),
            
            ],
        ),
      ),
    );
  }
}
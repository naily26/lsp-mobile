// import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_final/repositories/skema_repository.dart';

class Skema extends StatefulWidget {
  const Skema({Key? key}) : super(key: key);

  @override
  State<Skema> createState() => _SkemaState();
}

class _SkemaState extends State<Skema> {
   List _data = [];
  final String _tokenAuth = '';

  // Future Get Data
  Future _getAllData() async {
    try {
      var url = Uri.parse('https://lsp.intermediatech.id/api/get_kompetensi');
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ' + _tokenAuth},
      );
      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body)['result'];
        });
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
    // Pertama Kali widget dijalankan memanggil request
    _getAllData();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skema'),
      ),
      body: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.only(top: 20, right: 15, left: 18),
                child:Container(
                  width: (MediaQuery.of(context).size.width)-40,
                  height: 100,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border(
                      // top: BorderSide(width: 5.0, color: Color.fromARGB(255, 14, 111, 16)),
                      bottom: BorderSide(width: 1.0, color: Color.fromARGB(255, 14, 111, 16)),
                      left: BorderSide(width: 5.0, color: Color.fromARGB(255, 14, 111, 16)),
                      right: BorderSide(width: 1.0, color: Color.fromARGB(255, 14, 111, 16))
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _data[index]['nama_skema'],
                          style: TextStyle(color: Colors.black,
                          fontSize: 18),
                        ),
                        Row(
                          children: [
                            Text(
                       _data[index]['start'],
                              style: TextStyle(color: Color.fromARGB(255, 62, 62, 62), fontWeight: FontWeight.w400,
                              fontSize: 14),
                            ),
                            Spacer(),
                             Text(
                       _data[index]['end'],
                              style: TextStyle(color: Color.fromARGB(255, 62, 62, 62), fontWeight: FontWeight.w400,
                              fontSize: 14),
                            ),
                          ],
                        ),
                        // Text(
                        //   'sampai: ' + _data[index]['end'],
                        //   style: TextStyle(color: Color.fromARGB(255, 62, 62, 62), fontWeight: FontWeight.w400,
                        //   fontSize: 14),
                        // ),
                        Text(
                          'deskripsi: ' + _data[index]['deskripsi'],
                          style: TextStyle(color: Color.fromARGB(255, 62, 62, 62), fontWeight: FontWeight.w400,
                          fontSize: 14),
                        )
                      ],
                    ),
                  ),
            ));
          }),
    );
  }
}
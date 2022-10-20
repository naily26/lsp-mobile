import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class TUK extends StatefulWidget {
  const TUK({super.key});

  @override
  State<TUK> createState() => _TUKState();
}

class _TUKState extends State<TUK> {
    List _data = [];
  final String _tokenAuth = '';

  // Future Get Data
  Future _getAllData() async {
    try {
      var url = Uri.parse('https://lsp.intermediatech.id/api/get_tuk');
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
        title: const Text('TUK'),
      ),
      body: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return  Padding(
            padding: EdgeInsets.only(top: 15, right: 15, left: 18),
            child:Container(
              width: (MediaQuery.of(context).size.width)-40,
              height: 150,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Color.fromARGB(255, 14, 111, 16)),
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
                      _data[index]['name'],
                      style: TextStyle(color: Colors.black,
                      fontSize: 18),
                    ),
                   Padding(
                    padding: EdgeInsets.only(left: 7, top: 3),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.book,
                                color: Colors.black,
                                size: 19.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text(
                                  _data[index]['nama_skema'],
                                  style: TextStyle(color: Color.fromARGB(255, 62, 62, 62), fontWeight: FontWeight.w400,
                                  fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_city,
                                color: Colors.black,
                                size: 19.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text(
                                  _data[index]['lokasi'],
                                  style: TextStyle(color: Color.fromARGB(255, 62, 62, 62), fontWeight: FontWeight.w400,
                                  fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.black,
                                size: 19.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text(
                                  _data[index]['penanggung_jawab'],
                                  style: TextStyle(color: Color.fromARGB(255, 62, 62, 62), fontWeight: FontWeight.w400,
                                  fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                  ],
                ),
              ),
            )
          );
          }),
    );
  }

}
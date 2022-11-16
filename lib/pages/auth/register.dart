import 'package:flutter/material.dart';
import 'package:my_final/widget/my_text.dart';
import 'package:my_final/pages/auth/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:my_final/pages/auth/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class RegiterPage extends StatefulWidget {
  const RegiterPage({super.key});

  @override
  State<RegiterPage> createState() => _RegiterPageState();
}

class _RegiterPageState extends State<RegiterPage> {
  List _data = [];
  final String _tokenAuth = '';
  late String _val;
  final TextEditingController _inputEmail = TextEditingController();
  final TextEditingController _inputNIM = TextEditingController();
  final TextEditingController _inputNama = TextEditingController();
  // final TextEditingController _inputProdi = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Future Get Data
  Future _getAllData() async {
    try {
      var url = Uri.parse('https://lsp.intermediatech.id/api/get_data_prodi');
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

  Future _postDataJson() async {
    try {
      var url = Uri.parse('https://lsp.intermediatech.id/api/register');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer ' + _tokenAuth
      }, body: {
        'email': _inputEmail.text,
        'name': _inputNama.text,
        'nim' : _inputNIM.text,
        'prodi_id': dropdownvalue
      });
      if (response.statusCode == 200) {
        print('sukses');
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyLogin()));
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
  String dropdownvalue = 'jurusan';  
 
   @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(0), child: Container(color: Color.fromARGB(255, 14, 111, 16))),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(color: Color.fromARGB(255, 14, 111, 16), height: 220),
            Column(
              children: <Widget>[
                Container(height: 40),
                Container(

                  child: 
                  // Image.asset(
                  //   Img.get('logo_small_round.png'),
                  //   color: Colors.white,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                          'LSP Poliwangi',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                          fontSize: 24),
                        ),
                  ),
                  height: 80,
                ),
                Card(
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(6)),
                  margin: EdgeInsets.all(25),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child :  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(height: 25),
                          Text("SIGN UP", style: MyText.title(context)!.copyWith(
                              color: Colors.green[500], fontWeight: FontWeight.bold
                          )),
                          TextFormField(
                            controller: _inputNama,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Nama tidak boleh kosong';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(labelText: "Nama Lengkap",
                              labelStyle: TextStyle(color: Colors.blueGrey[400]),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey[400]!, width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey[400]!, width: 2),
                              ),
                            ),
                          ),
                          Container(height: 10),
                          TextFormField(
                            controller: _inputNIM,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'NIM tidak boleh kosong';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(labelText: "NIM",
                              labelStyle: TextStyle(color: Colors.blueGrey[400]),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey[400]!, width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey[400]!, width: 2),
                              ),
                            ),
                          ),
                          Container(height: 10),
                          TextFormField(
                            controller: _inputEmail,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'E-mail tidak boleh kosong';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(labelText: "E-mail",
                              labelStyle: TextStyle(color: Colors.blueGrey[400]),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey[400]!, width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey[400]!, width: 2),
                              ),
                            ),
                          ),
                          Container(height: 10),
                          DropdownButtonFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Prodi tidak boleh kosong';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(labelText: "Jurusan - Program Studi",
                              labelStyle: TextStyle(color: Colors.blueGrey[400]),
                                //  icon: const Icon(Icons.keyboard_arrow_down), 
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey[400]!, width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey[400]!, width: 2),
                              ),
                            ),
                           // value: dropdownvalue,
                            isExpanded: true,
                            items: _data.map((items) {
                                return DropdownMenuItem(
                                  value: items['id_prodi'].toString(),
                                  child: AutoSizeText(items['nama_jurusan']+' - '+items['nama_prodi'], maxLines: 2, maxFontSize: 14, ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                          ),

                          Container(height: 25),
                          Container(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 14, 111, 16),
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(20)
                                ),
                              ),
                              child: Text("SUBMIT", style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _postDataJson();
                                }
                              },
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: TextButton(
                              style: TextButton.styleFrom(primary: Colors.transparent),
                              child: Text("Sign in", style: TextStyle(color: Color.fromARGB(255, 14, 111, 16)),),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MyLogin()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                )
              ],
            )
          ],
        ),
      ),

    );
  }
}
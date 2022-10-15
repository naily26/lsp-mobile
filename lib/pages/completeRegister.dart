import 'package:flutter/material.dart';
import 'package:my_final/pages/master.dart';
import 'package:my_final/pages/login.dart';
import 'package:my_final/widget/my_text.dart';
import 'package:my_final/pages/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:my_final/pages/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:date_field/date_field.dart';

class CompleteRegiterPage extends StatefulWidget {
  const CompleteRegiterPage({super.key});

  @override
  State<CompleteRegiterPage> createState() => _CompleteRegiterPageState();
}

class _CompleteRegiterPageState extends State<CompleteRegiterPage> {
  List _data = [];
  List _dataUser = [];
  final String _tokenAuth = '';
  late String _val;
  final TextEditingController _inputTempatLahir = TextEditingController();
  final TextEditingController _inputNIK = TextEditingController();
  final TextEditingController _inputNoTelepon = TextEditingController();
  final TextEditingController _inputAlamat = TextEditingController();
  final TextEditingController _inputKabupaten = TextEditingController();
  final TextEditingController _inputProvinsi = TextEditingController();
  final TextEditingController _inputPendidikan = TextEditingController();
  final TextEditingController _inputPekerjaan = TextEditingController();
  final TextEditingController _inputPassword = TextEditingController();
  final TextEditingController _inputTanggaLahir = TextEditingController();
  final TextEditingController _inputTanggaUji = TextEditingController();
  final TextEditingController _inputTanggaPembekalan = TextEditingController();

  // final TextEditingController _inputProdi = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  Future _postDataJson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserId = prefs.getInt('UserId');
    try {
      var url = Uri.parse('https://lsp.intermediatech.id/api/complete-registration/'  + UserId.toString());
      var response = await http.post(url,
          headers: {'Authorization': 'Bearer ' + _tokenAuth},
          body: {
            'nik': _inputNIK.text, 
            'alamat': _inputAlamat.text,
            'jk': dropdownvalueJK,
            'kode_kabupaten': _inputKabupaten.text,
            'kode_provinsi': _inputProvinsi.text,
            'kode_pekerjaan': _inputPekerjaan.text,
            'kode_pendidikan': _inputPendidikan.text,
            'tanggal_lahir': _inputTanggaLahir.text,
            'no_telepon': _inputNoTelepon.text,
            'tempat_lahir': _inputTempatLahir.text,
            'kompetensi_id': dropdownvalueSkema,
            'tanggal_uji': _inputTanggaUji.text,
            'tanggal_pembekalan': _inputTanggaPembekalan.text,
            'password': _inputPassword.text
            });
      if (response.statusCode == 200) {
        print('sukses');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyLogin()));
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

  var UserId;
  late String UserName;
  var email;
  var nim;
  var jurusan;
  var prodi;
  Future _getAllDataUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserId = prefs.getInt('UserId');
    var UserName2 = prefs.getString('UserName');
    UserName = UserName2.toString();
    email = prefs.getString('email');
    nim = prefs.getString('nim');
    jurusan = prefs.getString('jurusan');
    prodi = prefs.getString('prodi');
  }

  bool isSwitched1 = true;

  var jenis_kelamin = ['laki-laki', 'perempuan'];

  @override
  void initState() {
    super.initState();
    // Pertama Kali widget dijalankan memanggil request
    _getAllData();
    _getAllDataUser().whenComplete(() {
      setState(() {});
    });
  }

  String dropdownvalueJK = '';
  String dropdownvalueSkema = 'skema';

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(color: Color.fromARGB(255, 14, 111, 16))),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(color: Color.fromARGB(255, 14, 111, 16), height: 220),
            Column(
              children: <Widget>[
                Container(height: 40),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'LSP Poliwangi',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ),
                  height: 80,
                ),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    margin: EdgeInsets.all(25),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(height: 25),
                            TextFormField(
                              readOnly: true,
                              initialValue: UserName,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Nama Lengkap",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                            ),
                            Container(height: 10),
                            TextFormField(
                              initialValue: nim.toString(),
                              readOnly: true,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "NIM",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                            ),
                            Container(height: 10),
                            TextFormField(
                              initialValue: jurusan.toString(),
                              readOnly: true,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Jurusan",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                            ),
                            Container(height: 10),
                            TextFormField(
                              initialValue: prodi.toString(),
                              readOnly: true,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Program Studi",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                            ),
                            Container(height: 10),
                            TextFormField(
                              readOnly: true,
                              initialValue: email.toString(),
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "E-mail",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                            ),
                            Container(height: 10),
                            TextFormField(
                              controller: _inputNIK,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'NIK tidak boleh kosong';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "NIK",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                            ),
                            Container(height: 10),
                            DropdownButtonFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Jenis kelamin tidak boleh kosong';
                                }
                                dropdownvalueJK = value;
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Jenis Kelamin",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: jenis_kelamin.map((String items) {
                                return DropdownMenuItem(
                                  value: items.toString(),
                                  child: AutoSizeText(
                                    items,
                                    style: TextStyle(fontSize: 15),
                                    maxLines: 1,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalueJK = newValue!;
                                });
                              },
                            ),
                            Container(height: 10),
                            TextFormField(
                              controller: _inputTempatLahir,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Tempat lahir tidak boleh kosong';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Tempat Lahir",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                            ),
                            Container(height: 10),
                            TextFormField(
                              controller: _inputTanggaLahir,
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.event_note,
                                    color: Colors.blueGrey[400]),
                                labelText: "Tannggal Lahir",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    _inputTanggaLahir.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                            ),
                            Container(height: 10),
                            TextFormField(
                              controller: _inputNoTelepon,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Nomor telepon tidak boleh kosong';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "No telepon",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                            ),
                            Container(height: 10),
                            TextFormField(
                              controller: _inputAlamat,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Alamat tidak boleh kosong';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Alamat",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                            ),
                            Container(height: 10),
                            TextFormField(
                              controller: _inputKabupaten,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Kabupaten tidak boleh kosong';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Kabupaten",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                            ),
                            Container(height: 10),
                            TextFormField(
                              controller: _inputProvinsi,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Provinsi tidak boleh kosong';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Provinsi",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                            ),
                            Container(height: 10),
                            TextFormField(
                              controller: _inputPendidikan,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Pendidikan tidak boleh kosong';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Pendidikan",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                            ),
                            Container(height: 10),
                            TextFormField(
                              controller: _inputPekerjaan,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Kode pekerjaan tidak boleh kosong';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Kode pekerjaan",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                            ),
                            Container(height: 10),
                            DropdownButtonFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Skema tidak boleh kosong';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Skema",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: _data.map((items) {
                                return DropdownMenuItem(
                                  value: items['id'].toString(),
                                  child: AutoSizeText(
                                    items['nama_skema'],
                                    style: TextStyle(fontSize: 15),
                                    maxLines: 1,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalueSkema = newValue!;
                                });
                              },
                            ),
                            Container(height: 10),
                            TextFormField(
                              controller: _inputTanggaUji,
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.event_note,
                                    color: Colors.blueGrey[400]),
                                labelText: "Rencana Tanggal Uji",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    _inputTanggaUji.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                            ),
                            Container(height: 10),
                            TextFormField(
                              controller: _inputTanggaPembekalan,
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.event_note,
                                    color: Colors.blueGrey[400]),
                                labelText: "Rencana Tanggal Pembekalan",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    _inputTanggaPembekalan.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                            ),
                            Container(height: 10),
                            TextFormField(
                              controller: _inputPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[400]!, width: 2),
                                ),
                              ),
                            ),
                            Container(height: 25),
                            Container(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 14, 111, 16),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20)),
                                ),
                                child: Text(
                                  "SUBMIT",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _postDataJson();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

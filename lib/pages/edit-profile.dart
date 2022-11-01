
import 'package:flutter/material.dart';
import 'package:my_final/pages/layout/SecondMaster.dart';
import 'package:my_final/pages/auth/login.dart';
import 'package:my_final/widget/my_text.dart';
import 'package:my_final/pages/auth/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:my_final/pages/auth/login.dart';

import 'package:my_final/widget/my_text.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:date_field/date_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var _data ;
  var _message;
  List _dataUser = [];
  final String _tokenAuth = '';
  late String _val;
  final TextEditingController _inputTempatLahir = TextEditingController();
  final TextEditingController _inputNIK = TextEditingController();
  final TextEditingController _inputEmail = TextEditingController();
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


  Future _postDataJson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserId = prefs.getInt('UserId');
    try {
      var url = Uri.parse('https://lsp.intermediatech.id/api/edit_profile/'  + UserId.toString());
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
            // 'password': _inputPassword.text,
            'email': _inputEmail.text
            }
        );
       setState(() {
          _data = json.decode(response.body)['data'];
          // _message = json.decode(response.body)['message'];
      });
      if (response.statusCode == 200) {
         postData(_data['user_id'], _data['id'], _data['name'], _data['nim'], _data['user']['email']);
         postDataDiri(
        _data['no_telepon'], _data['alamat'], _data['kode_kabupaten'], _data['kode_provinsi'], _data['kode_pekerjaan'], _data['kode_pendidikan'],
        _data['jenis_kelamin'], _data['tempat_lahir'], _data['tanggal_lahir'],  _data['nik'], _data['pengajuan']['file_apl_01'], _data['pengajuan']['file_apl_02']
        ); 

        print('sukses');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyMaster(indexTab: 2)));
            print(_data);
      } else {
        print('error1');
        _message = json.decode(response.body)['message'];
        _showToast(_message, context);
      }
    } on SocketException {
      print('no internet');
    } on HttpException {
      print('error2');
    } on FormatException {
      print('error3');
    }
  }

  postData(UserId, AsesiId, UserName, nim, email ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('AsesiId', AsesiId);
    prefs.setInt('UserId', UserId);
    prefs.setString('UserName', UserName);
    prefs.setString('nim', nim);
    prefs.setString('prodi', prodi);
    prefs.setString('jurusan', jurusan);
    prefs.setString('email', email);
  }

   postDataDiri(no_telepon, alamat, kabupaten, provinsi, pekerjaan, pendidikan, jk, tmpl , tgll, nik,
            file_apl_01, file_apl_02 ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.setString('no_telepon', no_telepon);
    prefs.setString('alamat', alamat);
    prefs.setString('kabupaten', kabupaten);
    prefs.setString('provinsi', provinsi);
    prefs.setString('pekerjaan', pekerjaan);
    prefs.setString('pendidikan', pendidikan);
    prefs.setString('jk', jk);
    prefs.setString('tmpl', tmpl);
    prefs.setString('tgll', tgll);
    prefs.setString('nik', nik);
  }

  void _showToast(String mesg, BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(mesg),
        action: SnackBarAction(label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  var UserId;
  String UserName = '';
  var email;
  var nim;
  var jurusan;
  var prodi;
  Future _getAllDataUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserId = prefs.getInt('UserId');
    var UserName2 = prefs.getString('UserName');
    UserName = UserName2.toString();
    _inputEmail.text = prefs.getString('email').toString();
    nim = prefs.getString('nim');
    jurusan = prefs.getString('jurusan');
    prodi = prefs.getString('prodi');
    _inputNoTelepon.text = prefs.getString('no_telepon').toString();
    _inputAlamat.text = prefs.getString('alamat').toString();
    _inputKabupaten.text = prefs.getString('kabupaten').toString();
    _inputProvinsi.text = prefs.getString('provinsi').toString();
    _inputPekerjaan.text = prefs.getString('pekerjaan').toString();
    _inputPendidikan.text = prefs.getString('pendidikan').toString();
    dropdownvalueJK = prefs.getString('jk').toString();
    _inputTempatLahir.text = prefs.getString('tmpl').toString();
    _inputTanggaLahir.text = prefs.getString('tgll').toString();
    _inputNIK.text = prefs.getString('nik').toString();
  }

  bool isSwitched1 = true;

  var jenis_kelamin = ['laki-laki', 'perempuan'];

  @override
  void initState() {
    super.initState();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Profile"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                 if (_formKey.currentState!.validate()) {
                                    _postDataJson();
                                  }
              },
            ),
          ]
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        scrollDirection: Axis.vertical,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                                controller: _inputEmail,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'E-mail tidak boleh kosong';
                                  }
                                  return null;
                                },
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
                                value: dropdownvalueJK,
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
                                    return 'Pekerjaan tidak boleh kosong';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: "Pekerjaan",
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
                              // TextFormField(
                              //   controller: _inputPassword,
                              //   // validator: (value) {
                              //   //   if (value!.isEmpty) {
                              //   //     return 'Password tidak boleh kosong';
                              //   //   }
                              //   //   return null;
                              //   // },
                              //   keyboardType: TextInputType.text,
                              //   style: TextStyle(color: Colors.black),
                              //   decoration: InputDecoration(
                              //     labelText: "Password",
                              //     labelStyle:
                              //         TextStyle(color: Colors.blueGrey[400]),
                              //     enabledBorder: UnderlineInputBorder(
                              //       borderSide: BorderSide(
                              //           color: Colors.blueGrey[400]!, width: 1),
                              //     ),
                              //     focusedBorder: UnderlineInputBorder(
                              //       borderSide: BorderSide(
                              //           color: Colors.blueGrey[400]!, width: 2),
                              //     ),
                              //   ),
                              // ),
                              Container(height: 25),
                              
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}

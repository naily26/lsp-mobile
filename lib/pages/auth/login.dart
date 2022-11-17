import 'package:flutter/material.dart';
import 'package:my_final/data/img.dart';
import 'package:my_final/data/my_colors.dart';
import 'package:my_final/pages/home.dart';
import 'package:my_final/pages/auth/waiting.dart';
import 'package:my_final/pages/auth/decline.dart';
import 'package:my_final/pages/auth/approve.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'package:my_final/widget/my_text.dart';
import 'package:my_final/pages/auth/register.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_final/pages/layout/SecondMaster.dart';

import 'package:my_final/widget/my_text.dart';
import 'package:my_final/widget/toolbar.dart';
import 'package:my_final/widget/my_toast.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final String _tokenAuth = '';
  final TextEditingController _inputEmail = TextEditingController();
  final TextEditingController _inputPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var UserId;
  var _data;
  var _message;
  // List<dynamic> _data = [];

  get userdata => null;

  Future _postDataJson() async {
    try {
      var url = Uri.parse('https://lsp.intermediatech.id/api/sign-in');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer ' + _tokenAuth
      }, body: {
        'email': _inputEmail.text,
        'password': _inputPassword.text,
      });
      setState(() {
        _data = json.decode(response.body)['data'];
        _message = json.decode(response.body)['message'];
      });
      if (response.statusCode == 200) {
        print(_data['user_id']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        postData(
            _data['user_id'],
            _data['id'],
            _data['name'],
            _data['nim'],
            _data['jurusan']['nama'],
            _data['prodi']['nama'],
            _data['user']['email']);
        if (_data['status'] == 'approve' && _data['nik'] != null) {
          postDataDiri(
              _data['no_telepon'],
              _data['alamat'],
              _data['kode_kabupaten'],
              _data['kode_provinsi'],
              _data['kode_pekerjaan'],
              _data['kode_pendidikan'],
              _data['jenis_kelamin'],
              _data['tempat_lahir'],
              _data['tanggal_lahir'],
              _data['nik'],
              _data['pengajuan']['file_apl_01'],
              _data['pengajuan']['file_apl_02']);
        }
        print('sukses');
        if (_data['status'] == 'approve') {
          if (_data['nik'] == null) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ValidasiApprove()));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyMaster(indexTab: 1)));
          }
        } else if (_data['status'] == 'decline') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ValidasiDecline()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Validasi()));
        }
      } else {
        print('error');
        return _showToast(_message.toString(), context);
      }
    } on SocketException {
      print('no internet');
    } on HttpException {
      print('error');
    } on FormatException {
      print('error');
    }
  }

  void _showToast(String mesg, BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(mesg),
        action: SnackBarAction(
            label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  postData(UserId, AsesiId, UserName, nim, jurusan, prodi, email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('AsesiId', AsesiId);
    prefs.setInt('UserId', UserId);
    prefs.setString('UserName', UserName);
    prefs.setString('nim', nim);
    prefs.setString('prodi', prodi);
    prefs.setString('jurusan', jurusan);
    prefs.setString('email', email);
  }

  postDataDiri(no_telepon, alamat, kabupaten, provinsi, pekerjaan, pendidikan,
      jk, tmpl, tgll, nik, file_apl_01, file_apl_02) async {
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

  bool passwordHidden = true;
  void _showPassword() {
    setState(() {
      passwordHidden = !passwordHidden;
    });
  }
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
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
                            Text("SIGN IN",
                                style: MyText.title(context)!.copyWith(
                                    color: Colors.green[500],
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              controller: _inputEmail,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Email",
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
                            TextFormField(
                              controller: _inputPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              obscureText: passwordHidden,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[400]),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _showPassword();
                                  },
                                  icon: (passwordHidden)
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
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
                            Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        child: Text(
                                          'Buat akun baru',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 14, 111, 16),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegiterPage()),
                                          );
                                        },
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        child: Text(
                                          'Lupa password ?',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 14, 111, 16)),
                                        ),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  CustomEventDialog());
                                        },
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomEventDialog extends StatefulWidget {
  CustomEventDialog({Key? key}) : super(key: key);

  @override
  CustomEventDialogState createState() => new CustomEventDialogState();
}

class CustomEventDialogState extends State<CustomEventDialog> {
  var no_wa;
  var data;
  Future getAdmin() async {
    try {
      var url = Uri.parse('https://lsp.intermediatech.id/api/get_admin');
      var response = await http.get(
        url,
        // headers: {'Authorization': 'Bearer ' + _tokenAuth},
      );
      if (response.statusCode == 200) {
        setState(() {
         data = json.decode(response.body)['result'];
           no_wa = 'https://wa.me/' + data['no_telepon'].toString();
        });
        print(no_wa);
        print('sukses');
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


  _launchUrl() async {
  if (await canLaunch(no_wa)) {
    await launch(no_wa);
  } else {
    throw 'Could not lauch';
  }
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 160,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                color: Color.fromARGB(255, 14, 111, 16),
                child: Column(
                  children: <Widget>[
                    Container(height: 10),
                    Icon(Icons.whatsapp, color: Colors.white, size: 80),
                    Container(height: 10),
                    Text("Lupa Password!",
                        style: MyText.title(context)!
                            .copyWith(color: Colors.white)),
                    Container(height: 10),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Text('Hubungi admin melalui nomor di bawah ini!!',
                        textAlign: TextAlign.center,
                        style: MyText.subhead(context)!
                            .copyWith(color: MyColors.grey_60)),
                    Container(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 14, 111, 16),
                        elevation: 0,
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0)),
                      ),
                      child: Text("Kontak admin",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: no_wa));
                        // _launchUrl();
                        MyToast.show("WhatsApp clicked", context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

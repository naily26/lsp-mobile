import 'package:flutter/material.dart';
import 'package:my_final/data/my_colors.dart';
import 'package:my_final/widget/my_text.dart';
import 'package:my_final/pages/layout/master.dart';
import 'package:my_final/pages/edit-profile.dart';
import 'package:my_final/pages/auth/edit-password.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List _data = [];
  final String _tokenAuth = '';

  var UserId;
  String UserName = '';
  String email = '';
  String nim = '';
  String jurusan = '';
  String prodi = '';
  String no_telepon = '';
  String alamat = '';
  String kabupaten = '';
  String provinsi = '';
  String pekerjaan = '';
  String pendidikan = '';
  String jk = '';
  String tmpl = '';
  String tgll = '';
  String nik = '';

  Future _getAllDataUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserId = prefs.getInt('UserId');
    UserName = prefs.getString('UserName').toString();
    email = prefs.getString('email').toString();
    nim = prefs.getString('nim').toString();
    jurusan = prefs.getString('jurusan').toString();
    prodi = prefs.getString('prodi').toString();
    no_telepon = prefs.getString('no_telepon').toString();
    alamat = prefs.getString('alamat').toString();
    kabupaten = prefs.getString('kabupaten').toString();
    provinsi = prefs.getString('provinsi').toString();
    pekerjaan = prefs.getString('pekerjaan').toString();
    pendidikan = prefs.getString('pendidikan').toString();
    jk = prefs.getString('jk').toString();
    tmpl = prefs.getString('tmpl').toString();
    tgll = prefs.getString('tgll').toString();
    nik = prefs.getString('nik').toString();
  }

  LogOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyMaster(indexTab: 1,)),
                          );
  }

  @override
  void initState() {
    super.initState();
    // Pertama Kali widget dijalankan memanggil request
    _getAllDataUser().whenComplete(() {
      setState(() {});
    });
  }

  bool isSwitched1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey_10,
      // body: Column(children: [
      //   Text((_data.length > 0 ? _data[0]['name'] : ''))
      // ]),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 180.0,
              floating: false,
              pinned: true,
              backgroundColor: Color.fromARGB(255, 14, 111, 16),
              flexibleSpace: FlexibleSpaceBar(),
              bottom: PreferredSize(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                    alignment: Alignment.bottomLeft,
                    constraints: BoxConstraints.expand(height: 50),
                    child: Row(
                      children: [
                        Text(UserName.toString(),
                            style: MyText.headline(context)!
                                .copyWith(color: Colors.white)),
                        Container(width: 5,),
                        GestureDetector(onTap: () {
                           Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EditProfilePage()));
                        }, child: Icon(Icons.edit, color: Colors.white,))
                      ],
                    ),
                  ),
                  preferredSize: Size.fromHeight(50)),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: (String value) {},
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      // value: "Settings",
                      child: GestureDetector(
                        child: Text("Log Out"),
                        onTap: () {
                         LogOut();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Info",
                              style: MyText.subhead(context)!.copyWith(
                                  color: MyColors.primaryDark,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(height: 10),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(nim,
                                  style: MyText.medium(context)
                                      .copyWith(color: MyColors.grey_80)),
                              Text("NIM",
                                  style: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ],
                          )),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(jurusan,
                                  style: MyText.medium(context)
                                      .copyWith(color: MyColors.grey_80)),
                              Text("Jurusan",
                                  style: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ],
                          )),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(prodi,
                                  style: MyText.medium(context)
                                      .copyWith(color: MyColors.grey_80)),
                              Text("Program studi",
                                  style: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ],
                          )),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(email,
                                  style: MyText.medium(context)
                                      .copyWith(color: MyColors.grey_80)),
                              Text("E-mail",
                                  style: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Container(height: 10),
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Bio",
                              style: MyText.subhead(context)!.copyWith(
                                  color: MyColors.primaryDark,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(height: 10),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  no_telepon,
                                  style: MyText.medium(context)
                                      .copyWith(color: MyColors.grey_80)),
                              Text("Phone",
                                  style: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ],
                          )),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  nik,
                                  style: MyText.medium(context)
                                      .copyWith(color: MyColors.grey_80)),
                              Text("NIK",
                                  style: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ],
                          )),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  jk,
                                  style: MyText.medium(context)
                                      .copyWith(color: MyColors.grey_80)),
                              Text("Jenis Kelamin",
                                  style: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ],
                          )),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  tmpl + ', ' + tgll,
                                  style: MyText.medium(context)
                                      .copyWith(color: MyColors.grey_80)),
                              Text("Tempat - tanggal Lahir",
                                  style: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ],
                          )),
                    ),
                     Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  pekerjaan,
                                  style: MyText.medium(context)
                                      .copyWith(color: MyColors.grey_80)),
                              Text("Pekerjaan",
                                  style: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ],
                          )),
                    ),
                     Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  pendidikan,
                                  style: MyText.medium(context)
                                      .copyWith(color: MyColors.grey_80)),
                              Text("Pendidikan",
                                  style: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ],
                          )),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  alamat,
                                  style: MyText.medium(context)
                                      .copyWith(color: MyColors.grey_80)),
                              Text("Alamat",
                                  style: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ],
                          )),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  kabupaten,
                                  style: MyText.medium(context)
                                      .copyWith(color: MyColors.grey_80)),
                              Text("Kabupaten",
                                  style: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ],
                          )),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  provinsi,
                                  style: MyText.medium(context)
                                      .copyWith(color: MyColors.grey_80)),
                              Text("Provinsi",
                                  style: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Container(height: 10),
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Support",
                              style: MyText.subhead(context)!.copyWith(
                                  color: MyColors.primaryDark,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(height: 10),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditPasswordPage()),
                          );
                      },
                      child: Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Text("Ganti Kata Sandi",
                            style: MyText.medium(context)
                                .copyWith(color: MyColors.grey_80)),
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Text("F A Q",
                            style: MyText.medium(context)
                                .copyWith(color: MyColors.grey_80)),
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Text("Privacy Policy",
                            style: MyText.medium(context)
                                .copyWith(color: MyColors.grey_80)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 15),
              Text("LSP mobile 1.0.0",
                  style: MyText.caption(context)!
                      .copyWith(color: MyColors.grey_40)),
              Container(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

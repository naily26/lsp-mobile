import 'package:flutter/material.dart';
import 'package:my_final/data/my_colors.dart';
import 'package:my_final/widget/my_text.dart';
import 'package:my_final/pages/master.dart';
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
   Future _getAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserId = prefs.getInt('UserId');
    // print(UserId);
    try {
      var url = Uri.parse('https://lsp-api.000webhostapp.com/api/get_data_user/' + UserId.toString());
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ' + _tokenAuth},
      );
      if (response.statusCode == 200) {
        setState(() {
           _data = json.decode(response.body)['data'];
        }
        );
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
              floating: false, pinned: true,
              backgroundColor: Color.fromARGB(255, 14, 111, 16),
              flexibleSpace: FlexibleSpaceBar(),
              bottom: PreferredSize(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                    alignment: Alignment.bottomLeft,
                    constraints: BoxConstraints.expand(height: 50),
                    child: Text((_data.length > 0 ? _data[0]['name'] : ''), style: MyText.headline(context)!.copyWith(color: Colors.white)),
                  ),
                  preferredSize: Size.fromHeight(50)
              ),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: (String value){},
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: "Settings",
                      child: GestureDetector(child: Text("Log Out"), 
                       onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const MyMaster()),
                                    );
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
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0),),
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
                          Text("Bio", style: MyText.subhead(context)!.copyWith(color: MyColors.primaryDark, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(height: 10),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text((_data.length > 0 ? _data[0]['no_telepon'] : ''), style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                              Text("Phone", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                            ],
                          )
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text((_data.length > 0 ? _data[0]['user']['email'].toString() : ''), style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                              Text("E-mail", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                            ],
                          )
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text((_data.length > 0 ? _data[0]['nik'].toString() : ''), style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                              Text("NIK", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                            ],
                          )
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text((_data.length > 0 ? _data[0]['jenis_kelamin'].toString() : ''), style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                              Text("Jenis Kelamin", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                            ],
                          )
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text((_data.length > 0 ? _data[0]['tempat_lahir'].toString() + ', ' + _data[0]['tanggal_lahir'].toString() : ''), style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                              Text("Tempat Tanggal Lahir", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                            ],
                          )
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text((_data.length > 0 ? _data[0]['alamat'].toString() : ''), style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                              Text("Alamat", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                            ],
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 10),
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0),),
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
                          Text("Info", style: MyText.subhead(context)!.copyWith(color: MyColors.primaryDark, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(height: 10),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text((_data.length > 0 ? _data[0]['nim'].toString() : ''), style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                              Text("NIM", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                            ],
                          )
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text((_data.length > 0 ? _data[0]['jurusan']['nama'].toString() : ''), style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                              Text("Jurusan", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                            ],
                          )
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text((_data.length > 0 ? _data[0]['prodi']['nama'].toString() : ''), style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                              Text("Program studi", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                            ],
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 10),
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0),),
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
                          Text("Support", style: MyText.subhead(context)!.copyWith(color: MyColors.primaryDark, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(height: 10),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Text("Ask a Question", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Text("F A Q", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Text("Privacy Policy", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 15),
              Text("LSP mobile 1.0.0", style: MyText.caption(context)!.copyWith(color: MyColors.grey_40)),
              Container(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
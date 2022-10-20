import 'package:flutter/material.dart';
import 'package:my_final/data/img.dart';
import 'package:my_final/data/my_colors.dart';
import 'package:my_final/widget/my_text.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Apl02Page extends StatefulWidget {
  const Apl02Page({super.key});

  @override
  State<Apl02Page> createState() => _Apl02PageState();
}

class _Apl02PageState extends State<Apl02Page> {
  String fileurl = "https://fluttercampus.com/sample.pdf";
  

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Template APL-02 berhasil diunduh'),
        action: SnackBarAction(
            label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _showToastFailed(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text(
          'Template APL-02 gagal diunduh',
        ),
        action: SnackBarAction(
            label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  

  var UserId;
  var file_apl_02;
  var nama_skema;
  String status_apl_01 = '';

  Future _getAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserId = prefs.getInt('UserId');
    file_apl_02 = prefs.getString('file_apl_02');
    nama_skema = prefs.getString('nama_skema');
    status_apl_01 = prefs.getString('status_apl_01').toString();
    print(file_apl_02);
    print(status_apl_01);
  }

  final String _tokenAuth = '';
  final _formKey = GlobalKey<FormState>();
  String _path = '';
  String _filename = '';

  Future _postFormData() async {
    try {
      Map<String, String> requestBody = <String, String>{
        // 'title': _inputTitle.text,
      };
      Map<String, String> headers = <String, String>{
        'contentType': 'multipart/form-data',
        'Authorization': 'Bearer ' + _tokenAuth
      };

      var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://lsp.intermediatech.id/api/upload-apl-02/' +
              UserId.toString()))
        ..headers.addAll(headers)
        ..fields.addAll(requestBody);
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('file', _path);
      request.files.add(multipartFile);
      var response = await request.send();
      var res = await http.Response.fromStream(response);

      if (res.statusCode == 200) {
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

  void _onChangeFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _path = file.path.toString();
        _filename = file.name.toString();
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllData().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      appBar: AppBar(
        title: const Text('APL-02'),
      ),
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Column(
            children: <Widget>[
              Container(
                color: Color.fromARGB(255, 14, 111, 16),
                width: double.infinity, height: 270,
                // child: Image.asset(Img.get('world_map.png'),fit: BoxFit.cover),
              )
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(height: 40),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1)),
                  color: Colors.white,
                  elevation: 2,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text(
                                'Template dokumen APL sudah tersedia, silahkan download, isi, dan upload kembali.',
                                style: MyText.body2(context)!
                                    .copyWith(color: MyColors.grey_60)),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Row(
                                children: [
                                  Container(
                                    height: 28,
                                    child: ElevatedButton(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.file_download_outlined,
                                            size: 18,
                                          ),
                                          Text(' Unduh template Apl-02',
                                              style: TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue[900],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      4))),
                                      onPressed: () async {
                                        Map<Permission, PermissionStatus>
                                            statuses = await [
                                          Permission.storage,
                                          //add more permission to request here.
                                        ].request();
                                        if (statuses[Permission.storage]!
                                            .isGranted) {
                                          var dir = await DownloadsPathProvider
                                              .downloadsDirectory;
                                          if (dir != null) {
                                            String savename = "apl-02.pdf";
                                            String savePath =
                                                dir.path + "/$savename";
                                            print(savePath);
                                            //output:  /storage/emulated/0/Download/banner.png

                                            try {
                                              await Dio()
                                                  .download(fileurl, savePath,
                                                      onReceiveProgress:
                                                          (received, total) {
                                                if (total != -1) {
                                                  print((received / total * 100)
                                                          .toStringAsFixed(0) +
                                                      "%");
                                                  //you can build progressbar feature too
                                                }
                                              });
                                              print(
                                                  "File is saved to download folder.");
                                              return _showToast(context);
                                            } on DioError catch (e) {
                                              print(e.message);
                                            }
                                          }
                                        } else {
                                          print(
                                              "No permission to read and write.");
                                          return _showToastFailed(context);
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 15,
                                  ),
                                  Container(
                                    height: 28,
                                    child: ElevatedButton(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.file_upload_outlined,
                                            size: 18,
                                          ),
                                          Text(' Unggah dokumen Apl-02',
                                              style: TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue[900],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      4))),
                                      onPressed: () {
                                          _onChangeFile();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            (_filename != ""
                                ? Form(
                                  key: _formKey,
                                  child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 15),
                                              child: Text("Dokumen",
                                                  style: MyText.body2(context)!
                                                      .copyWith(
                                                          color:
                                                              MyColors.grey_40)),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(
                                                          Icons
                                                              .text_snippet_outlined,
                                                          color:
                                                              MyColors.grey_40),
                                                      Container(width: 10),
                                                      Text(_filename,
                                                          style: MyText.body2(
                                                                  context)!
                                                              .copyWith(
                                                                  color: MyColors
                                                                      .grey_60))
                                                    ],
                                                  ),
                                                  Container(height: 10),
                                                  Container(
                                                      width: double.infinity,
                                                      height: 1,
                                                      color: MyColors.grey_20)
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              height: 28,
                                              child: ElevatedButton(
                                                child: Text('Simpan',
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.blue[900],
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(4))),
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    _postFormData();
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                )
                                : Container()),
                          ],
                        ),
                      )),
                ),
                Container(height: 8),
                (file_apl_02 != null) ?
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1)),
                  color: Colors.white,
                  elevation: 2,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Text("Dokumen",
                            style: MyText.body2(context)!
                                .copyWith(color: MyColors.grey_40)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.text_snippet_outlined,
                                    color: MyColors.grey_40),
                                Container(width: 10),
                                Text("dokumen-apl-02.pdf",
                                    style: MyText.body2(context)!
                                        .copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Container(
                                width: double.infinity,
                                height: 1,
                                color: MyColors.grey_20)
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Text("Info",
                            style: MyText.body2(context)!
                                .copyWith(color: MyColors.grey_40)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.event, color: MyColors.grey_40),
                                Container(width: 10),
                                Text(nama_skema.toString(),
                                    style: MyText.body2(context)!
                                        .copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            Container(
                                width: double.infinity,
                                height: 1,
                                color: MyColors.grey_20)
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Text("Status",
                            style: MyText.body2(context)!
                                .copyWith(color: MyColors.grey_40)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.layers, color: MyColors.grey_40),
                                Container(width: 10),
                                Text( status_apl_01,
                                    style: MyText.body2(context)!
                                        .copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                          ],
                        ),
                      ),
                      Container(height: 10),
                    ],
                  ),
                )
                : Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}

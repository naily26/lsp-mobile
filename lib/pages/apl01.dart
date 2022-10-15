import 'package:flutter/material.dart';
import 'package:my_final/data/img.dart';
import 'package:my_final/data/my_colors.dart';
import 'package:my_final/widget/my_text.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Apl01Page extends StatefulWidget {
  const Apl01Page({super.key});

  @override
  State<Apl01Page> createState() => _Apl01PageState();
}

class _Apl01PageState extends State<Apl01Page> {
  String fileurl = "https://fluttercampus.com/sample.pdf";

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Template APL-01 berhasil diunduh'),
        action: SnackBarAction(label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _showToastFailed(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Template APL-01 gagal diunduh', style: TextStyle(color: Colors.red),),
        action: SnackBarAction(label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text('APL-01'),
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
                                  GestureDetector(
                                    onTap: () async {
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
                                          String savename = "apl-01.pdf";
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
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.text_snippet_outlined,
                                          color: Colors.black,
                                          size: 21.0,
                                        ),
                                        Text('dokumen.pdf',
                                            style: MyText.body2(context)!
                                                .copyWith(
                                                    color: MyColors.grey_60)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 28,
                                    child: ElevatedButton(
                                      
                                      child: Text('Upload Apl-01',
                                          style: TextStyle(fontSize: 12)),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue[900],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      4))),
                                      onPressed: () => _showToast(context),

                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                ),
                Container(height: 5),
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
                                Text("dokumen-apl-01.pdf",
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
                                Text("11-02-2022",
                                    style: MyText.body2(context)!
                                        .copyWith(color: MyColors.grey_60))
                              ],
                            ),
                            Container(height: 10),
                            // Row(
                            //   children: <Widget>[
                            //     Icon(Icons.person, color: MyColors.grey_40),
                            //     Container(width: 10),
                            //     Text("2 child", style: MyText.body2(context)!.copyWith(color: MyColors.grey_60))
                            //   ],
                            // ),
                            // Container(height: 10),
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
                                Text("Asessment dilanjutkan",
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
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

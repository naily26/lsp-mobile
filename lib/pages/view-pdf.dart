import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

/// Represents PdfPage for Navigation
class PdfPage extends StatefulWidget {
  final String link;
  final String title;
  const PdfPage({Key? key, required this.link, required this.title}) : super(key: key);

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  // Uri myUri = Uri.parse(widget.link);
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Dokumen berhasil diunduh'),
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
          'Dokumen gagal diunduh',
          style: TextStyle(color: Colors.red),
        ),
        action: SnackBarAction(
            label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  String fileurl = '';

  @override
  void initState() {
     super.initState();
     fileurl = widget.link.toString();
    // printURL();
  }

  printURL() {
    print(widget.link);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Colors.black,
              semanticLabel: 'Download',
            ),
            onPressed: () async {
              // _pdfViewerKey.currentState?.openBookmarkView();
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
                                            String savename = widget.title+".pdf";
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
        ],
      ),
      body: SfPdfViewer.network(
        widget.link,
        key: _pdfViewerKey,
      ),
    );
  }
}
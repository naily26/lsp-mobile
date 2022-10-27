import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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

  @override
  void initState() {
     super.initState();
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
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
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
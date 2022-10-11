// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class AlurPage extends StatefulWidget {
//   const AlurPage({super.key});

//   @override
//   State<AlurPage> createState() => _AlurPageState();
// }

// class _AlurPageState extends State<AlurPage> {
// final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Syncfusion Flutter PDF Viewer'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(
//               Icons.bookmark,
//               color: Colors.white,
//               semanticLabel: 'Bookmark',
//             ),
//             onPressed: () {
//               _pdfViewerKey.currentState?.openBookmarkView();
//             },
//           ),
//         ],
//       ),
//       body: SfPdfViewer.network(
//         'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
//         key: _pdfViewerKey,
//       ),
//     );
//   }
// }
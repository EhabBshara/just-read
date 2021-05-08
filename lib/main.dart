import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf_text/pdf_text.dart';
import 'read.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just Read',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Just Read'),
        ),
        body: Browse(),
      ),
    );
  }
}

class Browse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BrowseState();
  }
}

class _BrowseState extends State<Browse> {
  File _browsedFile;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _BrowseFile,
            child: Text('Browse'),
          ),
          Text(_browsedFile != null ? formatFileName(_browsedFile.path) : ""),
        ],
      ),
    );
  }

  void _BrowseFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
      if (files.length > 0) {
        setState(() {
          _browsedFile = files[0];
        });
        _readPage();
      }
    } else {
      print('canceled');
    }
  }

  void _readPage() async {
    PDFDoc doc = await PDFDoc.fromFile(_browsedFile);
    PdfDocument fancydoc =
        PdfDocument(inputBytes: _browsedFile.readAsBytesSync());
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return Reading(formatFileName(_browsedFile.path), doc, fancydoc);
    });
    Navigator.of(context).push(route);
  }

  String formatFileName(String filename) {
    return filename.split('/').last;
  }
}

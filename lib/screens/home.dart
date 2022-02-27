import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_read/models/settings.dart';
import 'package:just_read/services/pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'package:just_read/widgets/appbar.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: "Just Read"),
      body: Browse(),
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
            onPressed: () => _browseFile(context),
            child: Text('Browse'),
          ),
          Text(_browsedFile != null ? formatFileName(_browsedFile.path) : ""),
        ],
      ),
    );
  }

  void _browseFile(BuildContext context) async {
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
        _readPage(context);
      }
    } else {
      print('canceled');
    }
  }

  void _readPage(BuildContext context) async {
    PDF pdf = PDF(file: _browsedFile);
    await pdf.init();
    _setPDF(context, pdf);
    Navigator.pushNamed(context, '/read');
  }

  void _setPDF(BuildContext context, PDF pdf) {
    var settings = context.read<Settings>();
    settings.setPDF(pdf);
  }

  String formatFileName(String filename) {
    return filename.split('/').last;
  }
}

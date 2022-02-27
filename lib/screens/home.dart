import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_read/services/pdf.dart';
import 'package:just_read/read.dart';
import 'package:file_picker/file_picker.dart';

double size = 20;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Just Read'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Container(
                  width: 120,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: TextField(
                              decoration:
                                  new InputDecoration(labelText: "Font Size"),
                              onSubmitted: (String value) =>
                                  size = double.parse(value),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      Row()
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
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
            onPressed: _browseFile,
            child: Text('Browse'),
          ),
          Text(_browsedFile != null ? formatFileName(_browsedFile.path) : ""),
        ],
      ),
    );
  }

  void _browseFile() async {
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
    PDF pdf = PDF(file: _browsedFile);
    await pdf.init();
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return Reading(formatFileName(_browsedFile.path), pdf, size);
    });
    Navigator.of(context).push(route);
  }

  String formatFileName(String filename) {
    return filename.split('/').last;
  }
}

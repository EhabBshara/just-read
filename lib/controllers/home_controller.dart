import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../models/settings.dart';
import '../screens/read.dart';
import '../services/pdf_reader.dart';
import '../services/pdf_text.dart';

class HomeController extends GetxController {
  final browsedFile = File("/").obs;
  final fileName = "".obs;

  void browse(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      if (files.length > 0) {
        updateFile(files[0]);
        updateFileName(browsedFile.value.path.split('/').last);
        _readPage(context);
      }
    } else {
      print('canceled');
    }
  }

  updateFile(File file) {
    browsedFile(file);
  }

  updateFileName(String fileName) {
    fileName = fileName;
  }

  void _readPage(BuildContext context) async {
    PDFReader pdf = PDFText();
    await pdf.readPDF(browsedFile.value);
    _setPDF(context, pdf);
    Get.to(() => Reading(),
        transition: Transition.rightToLeft,
        duration: Duration(seconds: 1),
        arguments: pdf);
  }

  void _setPDF(BuildContext context, PDFReader pdf) {
    var settings = context.read<Settings>();
    settings.setPDF(pdf);
  }
}

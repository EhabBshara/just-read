import 'dart:io';

import 'package:just_read/services/pdf_reader.dart';

class AndroidPDFReader implements PDFReader<void, String> {
  @override
  void pdf;

  @override
  late String pdfTitle;

  @override
  late int totalPages;

  @override
  Stream<String> pages() {
    // TODO: implement pages
    throw UnimplementedError();
  }

  @override
  readPDF(File file) {
    // TODO: implement readPDF
    throw UnimplementedError();
  }
  
}

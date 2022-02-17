import 'dart:io';

import 'package:just_read/services/pdf_reader.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFSyncfusion implements PDFReader<PdfDocument> {
  @override
  Stream<String> pages() async* {
    int pages = pdf.pages.count;
    for (var num = 0; num < pages; num++) {
      var page = await _pageGenerator(num);
      await Future<void>.delayed(const Duration(milliseconds: 10));
      yield page;
    }
  }

  Future<String> _pageGenerator(num) async {
    PdfTextExtractor extractor = PdfTextExtractor(pdf);
    Future.delayed(Duration(milliseconds: 1));
    return extractor.extractTextLines(startPageIndex: num).join("");
  }

  @override
  var pdf;

  @override
  getDoc(File file) async {
    pdf = PdfDocument(inputBytes: file.readAsBytesSync());
  }
}

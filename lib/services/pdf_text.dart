import 'package:just_read/services/pdf_reader.dart';
import 'package:pdf_text/pdf_text.dart';
import 'dart:io';

class PDFText implements PDFReader<PDFDoc, String> {
  @override
  var pdf;
  String pdfTitle;

  String get title => pdfTitle;
  @override
  Stream<String> pages() async* {
    for (var page in pdf.pages) {
      var content = await page.text;
      yield content;
    }
  }

  @override
  readPDF(File file) async {
    PDFDoc pddf = await PDFDoc.fromFile(file);
    pdf = pddf;
    pdfTitle = file.path.split("/").last;
  }
}

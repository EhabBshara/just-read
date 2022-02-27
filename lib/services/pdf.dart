import 'dart:io';

import 'package:just_read/services/pdf_reader.dart';
import 'package:just_read/services/pdf_syncfusion.dart';
import 'package:just_read/services/pdf_text.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDF {
  PDFReader<PDFDoc> pdfTextReader = PDFText();
  PDFReader<PdfDocument> pdfSyncfusion = PDFSyncfusion();
  final File file;
  String title;
  PDF({this.file});

  init() async {
    await pdfTextReader.getDoc(file);
    await pdfSyncfusion.getDoc(file);
    title = _formatFileName(file.path);
  }

  Stream<String> getPagesNormal() {
    return pdfTextReader.pages();
  }

  Stream<String> getPagesSyncfusion() {
    return pdfSyncfusion.pages();
  }

  String getFileName() {
    return title;
  }

  String _formatFileName(String filename) {
    return filename.split('/').last;
  }
}

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
  PDF({this.file});

  init() async {
    await pdfTextReader.getDoc(file);
    await pdfSyncfusion.getDoc(file);
  }

  Stream<String> getPagesNormal() {
    return pdfTextReader.pages();
  }

  Stream<String> getPagesSyncfusion() {
    return pdfSyncfusion.pages();
  }
}

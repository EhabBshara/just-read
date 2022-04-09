import 'dart:io';

abstract class PDFReader<T, P> {
  T pdf;
  String pdfTitle;
  readPDF(File file);
  Stream<P> pages();
}

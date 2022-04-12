import 'dart:io';

abstract class PDFReader<T, P> {
  late T pdf;
  late String pdfTitle;
  readPDF(File file);
  Stream<P> pages();
}

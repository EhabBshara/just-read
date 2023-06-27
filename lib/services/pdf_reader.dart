import 'dart:io';

/*
* An interface for PDFReader.
* T: the pdf specifc type depending on the reader used.
* P: the type of returned page content, simplest type is String.
*/
abstract class PDFReader<T, P> {
  late T pdf;
  late String pdfTitle;
  late int totalPages;
  readPDF(File file);
  Stream<P> pages();
}

import 'dart:io';

abstract class PDFReader<T> {
  T pdf;
  getDoc(File file);
  Stream<String> pages();
}

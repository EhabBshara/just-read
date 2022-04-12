import 'package:flutter/cupertino.dart';
import 'package:just_read/services/pdf_reader.dart';

class Settings extends ChangeNotifier {
  int _defaultFontSize = 20;
  int _fontSize = 20;
  late PDFReader _pdfReader;

  int get fontSize => _fontSize;
  PDFReader get pdf => _pdfReader;

  void changeFont(int newFontSize) {
    _fontSize = newFontSize > 10 ? newFontSize : _defaultFontSize;
    notifyListeners();
  }

  void setPDF(PDFReader pdf) {
    _pdfReader = pdf;
    notifyListeners();
  }
}

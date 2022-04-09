import 'package:flutter/cupertino.dart';
import 'package:just_read/services/pdf_reader.dart';

class Settings extends ChangeNotifier {
  double _defaultFontSize = 20;
  double _fontSize = 20;
  PDFReader _pdfReader;

  double get fontSize => _fontSize;
  PDFReader get pdf => _pdfReader;

  void changeFont(double newFontSize) {
    _fontSize = newFontSize > 10 ? newFontSize : _defaultFontSize;
    notifyListeners();
  }

  void setPDF(PDFReader pdf) {
    _pdfReader = pdf;
    notifyListeners();
  }
}

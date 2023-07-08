import 'package:flutter/material.dart';
import 'package:just_read/services/pdf_reader.dart';

class Settings extends ChangeNotifier {
  int _defaultFontSize = 20;
  int _fontSize = 20;
  int _goToPage = 0;
  late PDFReader _pdfReader;
  Color _textColor = Colors.cyan;
  Color _backgroundColor = Colors.black;

  int get fontSize => _fontSize;
  int get goToPageNum => _goToPage;
  PDFReader get pdf => _pdfReader;
  Color get textColor => _textColor;
  Color get backgroundColor => _backgroundColor;

  void changeFont(int newFontSize) {
    _fontSize = newFontSize > 10 ? newFontSize : _defaultFontSize;
    notifyListeners();
  }

  void goToPage(int num) {
    _goToPage = num;
    notifyListeners();
  }

  void setPDF(PDFReader pdf) {
    _pdfReader = pdf;
    notifyListeners();
  }

  void changeTextColor(Color color) {
    _textColor = color;
    notifyListeners();
  }

  void changeBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }
}

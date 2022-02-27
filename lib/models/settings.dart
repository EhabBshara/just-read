import 'package:flutter/cupertino.dart';
import 'package:just_read/services/pdf.dart';

class Settings extends ChangeNotifier {
  double fontSize_ = 20;
  PDF pdf_;
  double get fontSize => fontSize_;
  PDF get pdf => pdf_;
  void changeFont(double newFontSize) {
    fontSize_ = newFontSize;
    notifyListeners();
  }

  void setPDF(PDF pdf) {
    pdf_ = pdf;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../models/settings.dart';

class DocController extends GetxController {
  late Settings settings;
  late ItemScrollController scrollController;
  late ItemPositionsListener positionController;

  init(BuildContext context) {
    settings = context.read<Settings>();
    scrollController = ItemScrollController();
    positionController = ItemPositionsListener.create();
  }

  int getTotalPages() {
    return settings.pdf.totalPages;
  }

  Color getBackgroundColor() {
    return settings.backgroundColor;
  }

  Color textColor() {
    return settings.textColor;
  }

  Stream<dynamic> getPages() {
    return settings.pdf.pages();
  }

  void scrollTo() {
    int goToNum = settings.goToPageNum;
    if (goToNum != 0) {
      int index = goToNum <= settings.pdf.totalPages
          ? goToNum - 1
          : settings.pdf.totalPages;
      scrollController.scrollTo(
          index: index,
          duration: Duration(microseconds: 200),
          curve: Curves.easeInOutCubic);
      settings.goToPage(0);
    }
  }
}

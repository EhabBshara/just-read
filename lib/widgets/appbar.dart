import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_read/models/settings.dart';
import 'package:provider/provider.dart';
import 'colorPicker.dart';

AppBar buildAppBar(BuildContext context, {String title = ""}) {
  var fontController = TextEditingController();
  var goToController = TextEditingController();
  return AppBar(
    title: FittedBox(
      fit: BoxFit.fitWidth,
      child: title == ""
          ? Consumer<Settings>(
              builder: (context, settings, child) =>
                  Text(settings.pdf.pdfTitle),
            )
          : Text(title),
    ),
    actions: [
      PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    child: TextField(
                      controller: fontController,
                      decoration: InputDecoration(
                          labelText: "Font Size",
                          hintText: _getFontSize(context).toString()),
                      onChanged: (String value) =>
                          _changeFontSize(context, int.parse(value)),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    child: TextField(
                      controller: goToController,
                      decoration: InputDecoration(
                          labelText: "Go to page",
                          hintText:
                              context.read<Settings>().goToPageNum.toString()),
                      onSubmitted: (String value) =>
                          _goToPage(context, int.parse(value)),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  ColorPicker(
                      title: "Text color",
                      onColorChanged: (color) =>
                          context.read<Settings>().changeTextColor(color)),
                  ColorPicker(
                      title: "Background color",
                      onColorChanged: (color) => context
                          .read<Settings>()
                          .changeBackgroundColor(color)),
                ],
              ),
            ),
          ),
        ],
      )
    ],
  );
}

void _changeFontSize(BuildContext context, int newFontSize) {
  var settings = context.read<Settings>();
  settings.changeFont(newFontSize);
}

void _goToPage(BuildContext context, int pageNum) {
  var settings = context.read<Settings>();
  settings.goToPage(pageNum);
}

int _getFontSize(BuildContext context) {
  return context.read<Settings>().fontSize;
}

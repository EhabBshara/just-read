import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_read/models/settings.dart';
import 'package:provider/provider.dart';

AppBar buildAppBar(BuildContext context, {String title = ""}) {
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
              width: 200,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: TextField(
                          decoration:
                              new InputDecoration(labelText: "Font Size"),
                          onChanged: (String value) =>
                              _changeFontSize(context, double.parse(value)),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row()
                ],
              ),
            ),
          ),
        ],
      )
    ],
  );
}

void _changeFontSize(BuildContext context, double newFontSize) {
  var settings = context.read<Settings>();
  settings.changeFont(newFontSize);
}

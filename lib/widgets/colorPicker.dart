import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

typedef void OnColorChanged(Color color);

class ColorPicker extends StatelessWidget {
  final String title;
  final OnColorChanged onColorChanged;

  const ColorPicker(
      {Key? key, required this.title, required this.onColorChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _openColorPicker(context),
      child: Text("Change " + title),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(6),
        alignment: Alignment.bottomLeft,
      ),
    );
  }

  void _openColorPicker(BuildContext context) async {
    _openDialog(
      context,
      title + " picker",
      MaterialColorPicker(
        onColorChange: this.onColorChanged,
        onBack: () => print("Back button pressed"),
      ),
    );
  }

  void _openDialog(BuildContext context, String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            TextButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

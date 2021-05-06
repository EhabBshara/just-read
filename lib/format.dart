import 'package:flutter/material.dart';

class Format extends StatelessWidget {
  String text = "";
  final _biggerFont = const TextStyle(fontSize: 20, color: Colors.white);
  Format(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _biggerFont,
    );
  }
}

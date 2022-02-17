import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class Format extends StatelessWidget {
  List<TextLine> page;
  final _biggerFont = const TextStyle(fontSize: 20, color: Colors.white);
  Format(this.page);

  @override
  Widget build(BuildContext context) {
    List<TextSpan> children = [];
    for (var i = 0; i < page.length; i++) {
      List<TextWord> wordCollection = page[i].wordCollection;
      if (i != 0) {
        children.add(TextSpan(text: '\n'));
      }
      for (var j = 0; j < wordCollection.length; j++) {
        var text = wordCollection[j].text == null ? "" : wordCollection[j].text;
        if (text == "") {
          continue;
        }
        children.add(
          TextSpan(
            text: wordCollection[j].text == null ? "" : wordCollection[j].text,
            style: TextStyle(
              fontFamily: wordCollection[j].fontName,
              color: Colors.white,
              fontSize: wordCollection[j].fontSize,
            ),
          ),
        );
      }
    }
    return RichText(
      text: TextSpan(
        children: children,
      ),
    );
  }
}

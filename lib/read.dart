import 'package:flutter/material.dart';
import 'package:just_read/format.dart';
import 'package:pdf_text/pdf_text.dart';

class Reading extends StatefulWidget {
  final PDFDoc doc;
  final String title;
  Reading(this.title, this.doc);

  @override
  _ReadingState createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  final _pages = <String>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(widget.title),
        ),
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.settings)),
        ],
      ),
      body: _buildPage(),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildPage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(10),
      color: Colors.black,
      child: StreamBuilder<String>(
        stream: _generatePages(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            // add pages as they arrive to the list to display.
            _pages.add(snapshot.data);
            return ListView.separated(
                separatorBuilder: (context, index) => Column(
                      children: [
                        Text(
                          (index + 1).toString(),
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 2,
                        )
                      ],
                    ),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Format(
                      _pages[index + 1 < _pages.length ? index + 1 : index],
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[
              Container(
                child: CircularProgressIndicator(),
                width: 120,
                height: 120,
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }

  // Generates text from the pdf pages.
  Stream<String> _generatePages() async* {
    for (var page in widget.doc.pages) {
      var content = await page.text;
      yield content;
    }
  }
}

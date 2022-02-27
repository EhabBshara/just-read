import 'package:flutter/material.dart';
import 'package:just_read/services/pdf.dart';

class Reading extends StatefulWidget {
  final PDF reader;
  final String title;
  Reading(this.title, this.reader);

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
      ),
      body: _buildPage(),
      backgroundColor: Colors.black,
    );
  }

  void initState() {
    super.initState();
  }

  Widget _buildPage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(10),
      color: Colors.black,
      child: StreamBuilder<String>(
        stream: widget.reader.getPagesNormal(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
            _pageStreamBuilder(context, snapshot),
      ),
    );
  }

  Widget _pageStreamBuilder(
      BuildContext context, AsyncSnapshot<String> snapshot) {
    List<Widget> children;
    if (snapshot.hasData) {
      // add pages as they arrive to the list to display.
      print(_pages.length);
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
              title: Text(
                _pages[index],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
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
          child: Text(
            'Error: ${snapshot.error}',
            style: TextStyle(color: Colors.white),
          ),
        )
      ];
    } else {
      print('fetching');
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
  }
}

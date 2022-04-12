import 'package:flutter/material.dart';
import 'package:just_read/models/settings.dart';
import 'package:just_read/widgets/appbar.dart';
import 'package:provider/provider.dart';

class Reading extends StatelessWidget {
  final _pages = <dynamic>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
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
      child: Consumer<Settings>(
        builder: (context, settings, child) => StreamBuilder<dynamic>(
          stream: settings.pdf.pages(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
              _pageStreamBuilder(context, snapshot),
        ),
      ),
    );
  }

  Widget _pageStreamBuilder(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    List<Widget> children;
    if (snapshot.hasData) {
      // add pages as they arrive to the list to display.
      _pages.add(snapshot.data);
      return ListView.separated(
        separatorBuilder: (context, index) => Column(
          children: [
            Text(
              (index + 1).toString(),
              style: TextStyle(fontSize: 20, color: Colors.yellow),
            ),
            Divider(
              color: Colors.yellow,
              thickness: 2,
            )
          ],
        ),
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return PageView(page: _pages[index]);
        },
      );
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

class PageView extends StatelessWidget {
  final String page;

  PageView({required this.page});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Consumer<Settings>(
        builder: (context, settings, child) => Text(
          page,
          style: TextStyle(
            color: Colors.cyan,
            fontSize: settings.fontSize.toDouble(),
          ),
        ),
      ),
    );
  }
}

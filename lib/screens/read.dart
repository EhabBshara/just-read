import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_read/models/settings.dart';
import 'package:just_read/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Reading extends StatelessWidget {
  final _pages = <dynamic>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: _buildPage(context),
      backgroundColor: context.read<Settings>().backgroundColor,
    );
  }

  Widget _buildPage(BuildContext context) {
    var settings = context.read<Settings>();
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(10),
      color: context.read<Settings>().backgroundColor,
      child: _pages.length == settings.pdf.totalPages
          ? DocView(pages: _pages)
          : Consumer<Settings>(
              builder: (context, settings, child) => StreamBuilder<dynamic>(
                stream: settings.pdf.pages(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                        _pageStreamBuilder(context, snapshot),
              ),
            ),
    );
  }

  Widget _pageStreamBuilder(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    List<Widget> children;
    // avoid reading again if we already have all the pages.
    if (_pages.length == context.read<Settings>().pdf.totalPages) {
      return DocView(pages: _pages);
    }
    if (snapshot.hasData) {
      // add pages as they arrive to the list to display.
      _pages.add(snapshot.data);
      return DocView(pages: _pages);
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

class DocView extends StatefulWidget {
  final List<dynamic> pages;
  const DocView({Key? key, required this.pages}) : super(key: key);
  @override
  _DocViewState createState() => _DocViewState();
}

class _DocViewState extends State<DocView> {
  ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _positionController =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    Settings settings = context.read<Settings>();
    int goToNum = settings.goToPageNum;
    if (goToNum != 0) {
      _scrollController.scrollTo(
          index: goToNum <= settings.pdf.totalPages
              ? goToNum - 1
              : settings.pdf.totalPages,
          duration: Duration(microseconds: 200),
          curve: Curves.easeInOutCubic);
      context.read<Settings>().goToPage(0);
    }
    return Scrollbar(
      interactive: true,
      isAlwaysShown: true,
      child: ScrollablePositionedList.separated(
        itemScrollController: _scrollController,
        itemPositionsListener: _positionController,
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
        itemCount: widget.pages.length,
        itemBuilder: (context, index) {
          return PageViews(page: widget.pages[index]);
        },
      ),
    );
  }
}

class PageViews extends StatelessWidget {
  final String page;

  PageViews({required this.page});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Consumer<Settings>(
        builder: (context, settings, child) => Text(
          page,
          style: TextStyle(
            color: settings.textColor,
            fontSize: settings.fontSize.toDouble(),
          ),
        ),
      ),
    );
  }
}

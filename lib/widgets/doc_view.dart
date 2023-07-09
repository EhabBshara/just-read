import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_read/services/pdf_reader.dart';
import 'package:just_read/widgets/page_view.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../models/settings.dart';

class DocView extends StatefulWidget {
  final List<dynamic> _pages = [];
  final PDFReader pdf;

  DocView(this.pdf);
  @override
  _DocViewState createState() => _DocViewState();
}

class _DocViewState extends State<DocView> {
  late final ItemScrollController scrollController;
  late final ItemPositionsListener positionController;

  @override
  void initState() {
    super.initState();
    scrollController = ItemScrollController();
    positionController = ItemPositionsListener.create();
  }

  Widget _pageStreamBuilder(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    List<Widget> children;
    // avoid reading again if we already have all the pages.
    if (widget._pages.length == Provider.of<Settings>(context).pdf.totalPages) {
      return displayPages(context, widget._pages);
    }
    if (snapshot.hasData) {
      // add pages as they arrive to the list to display.
      widget._pages.add(snapshot.data);
      return displayPages(context, widget._pages);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Provider.of<Settings>(context).backgroundColor,
      child:
          widget._pages.length == Provider.of<Settings>(context).pdf.totalPages
              ? displayPages(context, widget._pages)
              : StreamBuilder<dynamic>(
                  stream: Provider.of<Settings>(context).pdf.pages(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                          _pageStreamBuilder(context, snapshot),
                ),
    );
  }

  Widget displayPages(BuildContext context, List<dynamic> pages) {
    int goToNum = Provider.of<Settings>(context).goToPageNum;
    if (goToNum != 0) {
      int index = goToNum <= Provider.of<Settings>(context).pdf.totalPages
          ? goToNum - 1
          : Provider.of<Settings>(context).pdf.totalPages;
      scrollController.scrollTo(
          index: index,
          duration: Duration(microseconds: 200),
          curve: Curves.easeInOutCubic);
      Provider.of<Settings>(context).goToPage(0);
    }
    return Scrollbar(
      thumbVisibility: true,
      child: ScrollablePositionedList.separated(
        itemScrollController: scrollController,
        itemPositionsListener: positionController,
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
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return SinglePageView(page: pages[index]);
        },
      ),
    );
  }
}

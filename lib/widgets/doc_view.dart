import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_read/controllers/doc_controller.dart';
import 'package:just_read/services/pdf_reader.dart';
import 'package:just_read/widgets/page_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DocView extends StatefulWidget {
  final List<dynamic> _pages = [];
  final PDFReader pdf;

  DocView(this.pdf);
  @override
  _DocViewState createState() => _DocViewState();
}

class _DocViewState extends State<DocView> {
  final DocController _controller = Get.put(DocController());

  Widget _pageStreamBuilder(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    List<Widget> children;
    // avoid reading again if we already have all the pages.
    if (widget._pages.length == _controller.getTotalPages()) {
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
    _controller.init(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(10),
      color: _controller.getBackgroundColor(),
      child: widget._pages.length == _controller.getTotalPages()
          ? displayPages(context, widget._pages)
          : StreamBuilder<dynamic>(
              stream: _controller.getPages(),
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                      _pageStreamBuilder(context, snapshot),
            ),
    );
  }

  Widget displayPages(BuildContext context, List<dynamic> pages) {
    _controller.scrollTo();
    return Scrollbar(
      thumbVisibility: true,
      controller: _controller.scrollController.primaryScrollController,
      child: ScrollablePositionedList.separated(
        itemScrollController: _controller.scrollController,
        itemPositionsListener: _controller.positionController,
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

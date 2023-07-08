import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_read/models/settings.dart';
import 'package:just_read/widgets/appbar.dart';
import 'package:provider/provider.dart';

import '../widgets/doc_view.dart';

class Reading extends StatelessWidget {
  var args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: _buildPage(context),
      backgroundColor: context.read<Settings>().backgroundColor,
    );
  }

  Widget _buildPage(BuildContext context) {
    print(args.toString());
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(10),
      color: context.read<Settings>().backgroundColor,
      child: DocView(args),
    );
  }
}

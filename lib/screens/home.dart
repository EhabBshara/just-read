import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_read/controllers/home_controller.dart';
import 'package:just_read/widgets/appbar.dart';

import '../plugin_example.dart';

class Home extends GetWidget<HomeController> {
  final HomeController c = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: "Just Read"),
      body: browse(context),
    );
  }

  Widget browse(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => c.browse(context),
            child: Text('Browse'),
          ),
          Text(c.fileName.value),
          ElevatedButton(
            onPressed: () => Get.to(PluginExample()),
            child: Text('Test Plugin'),
          ),
        ],
      ),
    );
  }
}

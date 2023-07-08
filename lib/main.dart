import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:just_read/screens/home.dart';
import 'package:provider/provider.dart';

import 'models/settings.dart';

void main() => runApp(JustRead());

class JustRead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Settings(),
      child: GetMaterialApp(
        title: 'Just Read',
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
        },
      ),
    );
  }
}

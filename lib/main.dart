import 'package:flutter/material.dart';
import 'package:just_read/plugin_example.dart';
import 'package:just_read/screens/home.dart';
import 'package:just_read/screens/read.dart';
import 'package:provider/provider.dart';

import 'models/settings.dart';

void main() => runApp(JustRead());

class JustRead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Settings(),
      child: MaterialApp(
        title: 'Just Read',
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/read': (context) => Reading(),
          '/plugin': (context) => PluginExample(),
        },
      ),
    );
  }
}

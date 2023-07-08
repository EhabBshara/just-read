import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/settings.dart';

class SinglePageView extends StatelessWidget {
  final String page;

  SinglePageView({required this.page});

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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_read/screens/home.dart';

void main() => runApp(JustRead());

class JustRead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just Read',
      home: Home(),
    );
  }
}

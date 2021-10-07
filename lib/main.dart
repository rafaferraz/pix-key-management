import 'package:flutter/material.dart';
import 'package:pix_key/utils.dart';

import 'home/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu Pix',
      home: const HomePage(),
    );
  }
}

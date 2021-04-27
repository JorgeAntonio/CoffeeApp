import 'package:flutter/material.dart';
import 'package:frappe_app/src/pages/main_frappe_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FrappeApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainFrappePage(),
    );
  }
}

//stack, positioned, sized box, expanded widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/home.dart';

void main() {
  runApp(MaterialApp(
      title: 'My App', home: HomePage(), debugShowCheckedModeBanner: false));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return home();
  }
}

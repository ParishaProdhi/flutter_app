//stack, positioned, sized box, expanded widget
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/home.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      title: 'My App', home: HomePage(), debugShowCheckedModeBanner: false));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var a;
  void initState() {
    a = AssetImage('assets/images/back.jpg');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          // color: Colors.white
            image: DecorationImage(
          image: a,
          fit: BoxFit.fill,
        )
        ),
        child: home());
  }
}

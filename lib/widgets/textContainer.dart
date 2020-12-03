import 'package:flutter/material.dart';

import 'nav-drawer.dart';

class textContainer extends StatefulWidget {
  final String title, body;
  textContainer(this.title, this.body);
  @override
  _textContainerState createState() => _textContainerState(title, body);
}

class _textContainerState extends State<textContainer> {
  var a;
  void initState() {
    a = AssetImage('assets/images/back.jpg');
    super.initState();
  }

  _textContainerState(final String title, body);
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
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Text('Krishi Loan'),
            backgroundColor: Colors.transparent,
          ),
          drawer: NavDrawer(),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    widget.body,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

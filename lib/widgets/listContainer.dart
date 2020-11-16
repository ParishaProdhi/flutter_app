import 'package:flutter/material.dart';

import 'nav-drawer.dart';

class listContainer extends StatefulWidget {
  final List<List> menu;
  listContainer(this.menu);
  @override
  _listContainerState createState() => _listContainerState(menu);
}

class _listContainerState extends State<listContainer> {
  var a;
  void initState() {
    a = NetworkImage(
        'https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fback.jpg?alt=media&token=12c57aa2-3d6e-4ff8-91fb-2a951cc5ab3d');
    super.initState();
  }

  _listContainerState(final List<List> menu);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: a,
          fit: BoxFit.fill,
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Krishi Loan'),
              backgroundColor: Colors.transparent,
            ),
            drawer: NavDrawer(),
            body: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
              // alignment: Alignment.center,
              child: ListView.builder(
                  itemCount: widget.menu.length,
                  itemBuilder: (BuildContext context, int index) {
                    //return Text(widget.menu[index]);
                    return SingleChildScrollView(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                                height: 75,
                                width: 200,
                                child: Card(
                                  child: RaisedButton(
                                    color: Colors.orange,
                                    child: Text(
                                      widget.menu[index][0],
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                widget.menu[index][1]),
                                      );
                                      // print('You tapped on RaisedButton');
                                    },
                                  ),
                                )),
                          ],
                        ));
                  }),
            )));
  }
}

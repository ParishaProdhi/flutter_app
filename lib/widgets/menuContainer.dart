import 'package:flutter/material.dart';

import 'nav-drawer.dart';

class menuContainer extends StatefulWidget {
  final List<List> menu;
  menuContainer(this.menu);
  @override
  _menuContainerState createState() => _menuContainerState(menu);
}

class _menuContainerState extends State<menuContainer> {
  var a;
  void initState() {
    a = NetworkImage(
        'https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fback.jpg?alt=media&token=12c57aa2-3d6e-4ff8-91fb-2a951cc5ab3d');
    super.initState();
  }

  _menuContainerState(final List<List> menu);
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
              padding: EdgeInsets.all(40.0),
              child: Center(
                  child: OrientationBuilder(builder: (context, orientation) {
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: widget.menu.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                    crossAxisSpacing: 40.0,
                    mainAxisSpacing: 40.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return AspectRatio(
                      aspectRatio: 2 / 3,
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
                                  builder: (context) => widget.menu[index][1]),
                            );
                            // print('You tapped on RaisedButton');
                          },
                        ),
                      ),
                    );
                  },
                );
              })),
            )));
  }
}

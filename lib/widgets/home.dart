import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'docs.dart';
import 'form.dart';

class home extends StatefulWidget {
  final id;
  home([this.id]);
  @override
  _homeState createState() => _homeState(id);
}

class _homeState extends State<home> {
  _homeState(final id);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var i, count = 0;
    List _mloan = [];
    for (i = 1; i < loan_mtype.length; i++) {
      if (loan_mtype[i]["id"] - 1 == widget.id) {
        count++;
        _mloan.add(loan_mtype[i]);
      }
    }

    String _title =
        (widget.id) != null ? loan_type[widget.id]["bangla_name"] : "কৃষি ঋণ";
    int _length = (widget.id) != null ? count : loan_type.length;
    List _result = (widget.id) != null ? _mloan : loan_type;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/back.jpg'),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Text(_title),
            backgroundColor: Colors.transparent,
          ),
          body: Container(
              child: ListView.builder(
            itemCount: _length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 90,
                    width: 360,
                    child: ListTile(
                      tileColor: Colors.yellow,
                      title: Text(
                        _result[index]["bangla_name"],
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // subtitle: Text(loan_type[index]["name"]),
                      onTap: () => {
                        (widget.id != null)
                            ? {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FormPage(_result[index])))
                              }
                            : {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            home(_result[index]["id"] - 1)))
                              }
                      },
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          ))),
    );
  }
}

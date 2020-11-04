import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/widgets/docs.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'docs.dart';

class FormPage extends StatefulWidget {
  final _result;
  FormPage(this._result);
  @override
  _FormPageState createState() => _FormPageState(_result);
}

class _FormPageState extends State<FormPage> {
  var formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var name, phone, nid, bday, gender, preadd, peradd, reg, br;

  _FormPageState(final _result);
  List<String> region = [];
  void initState() {
    _getRegionList();
    super.initState();
  }

  _showSnackBar() {
    var _mySnackBar =
        SnackBar(content: Text("আপনার তথ্যসমূহ কতৃপক্ষের নিকট পৌছে যাবে"));
    _scaffoldKey.currentState.showSnackBar(_mySnackBar);
  }

  _sendMail() async {
    String username = 'application.bkb@gmail.com';
    String password = '03-11-2020';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Bangladesh Krishi Bank')
      ..recipients.add('prodhi18@gmail.com')
      ..subject = 'নিম্নোক্ত ঋণগ্রহণে ইচ্ছুক গ্রাহকের সহিত যোগাযোগ করুন'
      ..html = "<div>"
          "<h1><b>ঋণের ধরণঃ</b>${loan_type[widget._result["id"] - 1]["bangla_name"]}(${widget._result["bangla_name"]})<br></h1>"
          "<div>"
          "<b>নামঃ</b>${this.name}<br>"
          "<b>যোগাযোগঃ</b>${this.phone}<br>"
          "<b>স্মার্ট কার্ড/জাতীয় পরিচয়পত্র নংঃ</b>${this.nid}<br>"
          "<b>স্থায়ী ঠিকানাঃ</b>${this.peradd}<br>"
          "<b>বর্তমান ঠিকানাঃ</b>${this.peradd}<br>"
          "<b>লিঙ্গঃ</b>${this.gender}<br>"
          "<b>জন্মতারিখঃ</b>${this.bday}<br>"
          "</div></div>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

    var connection = PersistentConnection(smtpServer);

    await connection.send(message);

    await connection.close();
  }

  Future<void> handleSubmit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      _showSnackBar();
      // _sendMail();
      _getRegionList();
      print(this.reg + this.br);
    }
  }

  List regionList;
  Future<String> _getRegionList() async {
    await rootBundle.loadString("assets/json/regions.json").then((responseReg) {
      var dataReg = json.decode(responseReg);

      setState(() {
        regionList = dataReg;
      });
    });
  }

  List branchList;

  Future<String> _getBranchList(String _region) async {
    print("Hello I am hit!");
    print(regionList[int.parse(_region)]['name']);
    await rootBundle.loadString("assets/json/branches.json").then((response) {
      var data = json.decode(response);
      var appropriateData = [];
      int i;
      for (i = 1; i < data.length; i++) {
        if (data[i]["region"] == regionList[int.parse(_region)]['name']) {
          appropriateData.add(data[i]);
        }
      }
      setState(() {
        branchList = appropriateData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String _value = '--Select--';
    int i;
    bday = '';
    String _region = '0';
    String _branch;
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/back.jpg'),
          fit: BoxFit.fill,
        )),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Text("প্রাথমিক তথ্যাবলী"),
            backgroundColor: Colors.transparent,
          ),
          body: ListView(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                      child: TextFormField(
                        // controller: nameCtrl,
                        decoration: InputDecoration(labelText: 'নাম'),
                        validator: (value) {
                          if (value.isEmpty) return ("নাম প্রদান আবশ্যক");
                        },
                        onSaved: (value) {
                          this.name = value;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                      child: TextFormField(
                        // controller: phoneCtrl,
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        decoration: InputDecoration(labelText: 'যোগাযোগ'),
                        validator: (value) {
                          if (value.length < 11)
                            return ("যোগাযোগের নম্বর অবশ্যই ১১ অংকের হতে হবে");
                        },
                        onSaved: (value) {
                          this.phone = value;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                      child: TextFormField(
                        // controller: nidCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'স্মার্ট কার্ড/জাতীয় পরিচয়পত্র নং'),
                        validator: (value) {
                          if (value.length != 10)
                            return ("সঠিক তথ্য প্রদান করুন");
                        },
                        onSaved: (value) {
                          this.nid = value;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                      child: TextFormField(
                        // controller: preaddCtrl,
                        decoration:
                            InputDecoration(labelText: 'বর্তমান ঠিকানা'),
                        validator: (value) {
                          if (value.isEmpty) return ("আবশ্যক তথ্য");
                        },
                        onSaved: (value) {
                          this.preadd = value;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                      child: TextFormField(
                        // controller: peraddCtrl,
                        decoration: InputDecoration(labelText: 'স্থায়ী ঠিকানা'),
                        validator: (value) {
                          if (value.isEmpty) return ("আবশ্যক তথ্য");
                        },
                        onSaved: (value) {
                          this.peradd = value;
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                          child: SizedBox(
                            width: 100,
                            child: Text(
                              'জন্মতারিখ ',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'DD'),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2),
                            ],
                            onSaved: (value) {
                              this.bday += value;
                            },
                            validator: (value) {
                              if (value.isEmpty) return ("আবশ্যক তথ্য");
                            },
                          ),
                        ),
                        Text('   '),
                        SizedBox(
                          width: 50,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'MM'),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2),
                            ],
                            onSaved: (value) {
                              this.bday += '-' + value;
                            },
                            validator: (value) {
                              if (value.isEmpty) return ("আবশ্যক তথ্য");
                            },
                          ),
                        ),
                        Text('   '),
                        SizedBox(
                          width: 94,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'YYYY'),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                            ],
                            onSaved: (value) {
                              this.bday += '-' + value;
                            },
                            validator: (value) {
                              if (value.isEmpty) return ("আবশ্যক তথ্য");
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                          child: SizedBox(
                            width: 100,
                            child: Text(
                              'লিঙ্গ ',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          // width: 200,
                          // height: 200,
                          padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                          child: DropdownButtonFormField<String>(
                            value: _value,
                            onChanged: (String value) {
                              setState(() {
                                _value = value;
                              });
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'আবশ্যক তথ্য';
                              }
                            },
                            items: [
                              DropdownMenuItem(
                                child: Text('--Select--'),
                                value: '--Select--',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  'পুরুষ',
                                ),
                                value: 'পুরুষ',
                              ),
                              DropdownMenuItem(
                                child: Text('মহিলা'),
                                value: 'মহিলা',
                              ),
                              DropdownMenuItem(
                                child: Text('অন্যান্য'),
                                value: 'অন্যান্য',
                              ),
                            ],
                            onSaved: (value) {
                              this.gender = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                          child: SizedBox(
                            width: 100,
                            child: Text(
                              'যে ব্রাঞ্চ থেকে ঋণ গ্রহণ করবেন',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              width: 216,
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: _region,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _region = newValue;
                                    _getBranchList(_region);
                                  });
                                },
                                hint: Text('Select Region'),
                                items: regionList?.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item['name']),
                                        value: item['id'].toString(),
                                      );
                                    })?.toList() ??
                                    [],
                                onSaved: (value) {
                                  this.reg =
                                      regionList[int.parse(value)]['name'];
                                },
                              ),
                            ),
                            SizedBox(
                              width: 216,
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: _branch,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _branch = newValue;
                                  });
                                },
                                hint: Text('Select Branch'),
                                items: branchList?.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['branch_name']),
                                        value: item['id'].toString(),
                                      );
                                    })?.toList() ??
                                    [],
                                onSaved: (value) {
                                  this.br = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: 150,
                      child: RaisedButton(
                        color: Colors.orange,
                        child: Text(
                          'দাখিল করুন',
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: handleSubmit,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}

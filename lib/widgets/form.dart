import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class FormPage extends StatefulWidget {
  // final _result;
  // FormPage(this._result);
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  var formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var name, phone, nid, bday, gender, preadd, peradd, div, dis, upa, uni;

  // _FormPageState(final _result);
  void initState() {
    _getDivisionList();
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
          "<h1><b>নামঃ</b>${this.name}<br></h1>"
          "<div>"
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
    }
  }

  List divisionList;
  Future<String> _getDivisionList() async {
    print("Hello I am hit");
    await rootBundle
        .loadString("assets/json/divisions.json")
        .then((responseDiv) {
      var dataReg = json.decode(responseDiv);

      setState(() {
        divisionList = dataReg;
      });
    });
  }

  List districtList;

  Future<String> _getDistrictList(String _district) async {
    // print(divisionList[int.parse(_district)]['name']);
    await rootBundle
        .loadString("assets/json/districts.json")
        .then((responseDis) {
      var dataDis = json.decode(responseDis);
      var appropriateDataDis = [];
      appropriateDataDis.add(dataDis[0]);
      int i;
      for (i = 1; i < dataDis.length; i++) {
        if (dataDis[i]["division_id"] == _district) {
          appropriateDataDis.add(dataDis[i]);
        }
      }
      setState(() {
        districtList = appropriateDataDis;
      });
    });
  }

  List upazillaList;

  Future<String> _getUpazillaList(String _upazilla) async {
    // print(divisionList[int.parse(_district)]['name']);
    await rootBundle
        .loadString("assets/json/upazillas.json")
        .then((responseUpa) {
      var dataUpa = json.decode(responseUpa);
      var appropriateDataUpa = [];
      appropriateDataUpa.add(dataUpa[0]);
      int i;
      for (i = 1; i < dataUpa.length; i++) {
        if (dataUpa[i]["district_id"] == _upazilla) {
          appropriateDataUpa.add(dataUpa[i]);
        }
      }
      setState(() {
        upazillaList = appropriateDataUpa;
      });
    });
  }

  List unionList;

  Future<String> _getUnionList(String _upazilla) async {
    print("I am hit!!!");
    // print(divisionList[int.parse(_district)]['name']);
    await rootBundle.loadString("assets/json/unions.json").then((responseUni) {
      var dataUni = json.decode(responseUni);
      var appropriateDataUni = [];
      appropriateDataUni.add(dataUni[0]);
      int i;
      for (i = 1; i < dataUni.length; i++) {
        if (dataUni[i]["upazilla_id"] == _upazilla) {
          appropriateDataUni.add(dataUni[i]);
        }
      }
      setState(() {
        unionList = appropriateDataUni;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String _value = '--Select--';
    bday = '';
    String _division = '0';
    String _district = '0';
    String _upazilla = '0';
    String _union = '0';
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
                    // Container(
                    //   padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                    //   child: TextFormField(
                    //     // controller: preaddCtrl,
                    //     decoration:
                    //         InputDecoration(labelText: 'বর্তমান ঠিকানা'),
                    //     validator: (value) {
                    //       if (value.isEmpty) return ("আবশ্যক তথ্য");
                    //     },
                    //     onSaved: (value) {
                    //       this.preadd = value;
                    //     },
                    //   ),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                    //   child: TextFormField(
                    //     // controller: peraddCtrl,
                    //     decoration: InputDecoration(labelText: 'ঠিকানা'),
                    //     validator: (value) {
                    //       if (value.isEmpty) return ("আবশ্যক তথ্য");
                    //     },
                    //     onSaved: (value) {
                    //       this.peradd = value;
                    //     },
                    //   ),
                    // ),
                    // Row(
                    //   children: <Widget>[
                    //     Container(
                    //       padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                    //       child: SizedBox(
                    //         width: 100,
                    //         child: Text(
                    //           'জন্মতারিখ ',
                    //           style: TextStyle(fontSize: 16),
                    //         ),
                    //       ),
                    //     ),
                    //     // SizedBox(
                    //     //   width: 50,
                    //     //   child: TextFormField(
                    //     //     keyboardType: TextInputType.number,
                    //     //     decoration: InputDecoration(labelText: 'DD'),
                    //     //     inputFormatters: [
                    //     //       LengthLimitingTextInputFormatter(2),
                    //     //     ],
                    //     //     onSaved: (value) {
                    //     //       this.bday += value;
                    //     //     },
                    //     //     validator: (value) {
                    //     //       if (value.isEmpty) return ("আবশ্যক তথ্য");
                    //     //     },
                    //     //   ),
                    //     // ),
                    //     // Text('   '),
                    //     // SizedBox(
                    //     //   width: 50,
                    //     //   child: TextFormField(
                    //     //     keyboardType: TextInputType.number,
                    //     //     decoration: InputDecoration(labelText: 'MM'),
                    //     //     inputFormatters: [
                    //     //       LengthLimitingTextInputFormatter(2),
                    //     //     ],
                    //     //     onSaved: (value) {
                    //     //       this.bday += '-' + value;
                    //     //     },
                    //     //     validator: (value) {
                    //     //       if (value.isEmpty) return ("আবশ্যক তথ্য");
                    //     //     },
                    //     //   ),
                    //     // ),
                    //     // Text('   '),
                    //     // SizedBox(
                    //     //   width: 94,
                    //     //   child: TextFormField(
                    //     //     keyboardType: TextInputType.number,
                    //     //     decoration: InputDecoration(labelText: 'YYYY'),
                    //     //     inputFormatters: [
                    //     //       LengthLimitingTextInputFormatter(4),
                    //     //     ],
                    //     //     onSaved: (value) {
                    //     //       this.bday += '-' + value;
                    //     //     },
                    //     //     validator: (value) {
                    //     //       if (value.isEmpty) return ("আবশ্যক তথ্য");
                    //     //     },
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
                    // Row(
                    //   children: <Widget>[
                    //     Container(
                    //       padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                    //       child: SizedBox(
                    //         width: 100,
                    //         child: Text(
                    //           'লিঙ্গ ',
                    //           style: TextStyle(fontSize: 16),
                    //         ),
                    //       ),
                    //     ),
                    //     // Container(
                    //     //   width: 150,
                    //     //   // width: 200,
                    //     //   // height: 200,
                    //     //   padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                    //     //   child: DropdownButtonFormField<String>(
                    //     //     value: _value,
                    //     //     onChanged: (String value) {
                    //     //       setState(() {
                    //     //         _value = value;
                    //     //       });
                    //     //     },
                    //     //     validator: (String value) {
                    //     //       if (value.isEmpty) {
                    //     //         return 'আবশ্যক তথ্য';
                    //     //       }
                    //     //     },
                    //     //     items: [
                    //     //       DropdownMenuItem(
                    //     //         child: Text('--Select--'),
                    //     //         value: '--Select--',
                    //     //       ),
                    //     //       DropdownMenuItem(
                    //     //         child: Text(
                    //     //           'পুরুষ',
                    //     //         ),
                    //     //         value: 'পুরুষ',
                    //     //       ),
                    //     //       DropdownMenuItem(
                    //     //         child: Text('মহিলা'),
                    //     //         value: 'মহিলা',
                    //     //       ),
                    //     //       DropdownMenuItem(
                    //     //         child: Text('অন্যান্য'),
                    //     //         value: 'অন্যান্য',
                    //     //       ),
                    //     //     ],
                    //     //     onSaved: (value) {
                    //     //       this.gender = value;
                    //     //     },
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                          child: SizedBox(
                            width: 100,
                            child: Text(
                              'ঠিকানা',
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
                                value: _division,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _division = newValue;
                                    _getDistrictList(_division);
                                  });
                                },
                                hint: Text('Select District'),
                                items: divisionList?.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item['name']),
                                        value: item['id'].toString(),
                                      );
                                    })?.toList() ??
                                    [],
                                onSaved: (value) {
                                  this.div =
                                      divisionList[int.parse(value)]['name'];
                                },
                              ),
                            ),
                            SizedBox(
                              width: 216,
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: _district,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _district = newValue;
                                    _getUpazillaList(_district);
                                  });
                                },
                                hint: Text('Select Branch'),
                                items: districtList?.map((item) {
                                      return new DropdownMenuItem(
                                        child: Text(item['name']),
                                        value: item['id'].toString(),
                                      );
                                    })?.toList() ??
                                    [],
                                onSaved: (value) {
                                  this.dis =
                                      districtList[int.parse(value)]['name'];
                                },
                              ),
                            ),
                            SizedBox(
                              width: 216,
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: _upazilla,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _upazilla = newValue;
                                    _getUnionList(_upazilla);
                                  });
                                },
                                hint: Text('Select Upazilla'),
                                items: upazillaList?.map((item) {
                                      return new DropdownMenuItem(
                                        child: Text(item['name']),
                                        value: item['id'].toString(),
                                      );
                                    })?.toList() ??
                                    [],
                                onSaved: (value) {
                                  this.upa =
                                      upazillaList[int.parse(value)]['name'];
                                },
                              ),
                            ),
                            SizedBox(
                              width: 216,
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: _union,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _union = newValue;
                                  });
                                },
                                hint: Text('Select Union'),
                                items: unionList?.map((item) {
                                      return new DropdownMenuItem(
                                        child: Text(item['name']),
                                        value: item['id'].toString(),
                                      );
                                    })?.toList() ??
                                    [],
                                onSaved: (value) {
                                  this.uni =
                                      unionList[int.parse(value)]['name'];
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

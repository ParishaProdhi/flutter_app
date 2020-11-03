import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  var formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var name, phone, nid, bday = '', gender, preadd, peradd;

  _showSnackBar() {
    var _mySnackBar =
        SnackBar(content: Text("আপনার তথ্যসমূহ কতৃপক্ষের নিকট পৌছে যাবে"));
    _scaffoldKey.currentState.showSnackBar(_mySnackBar);
  }

  Future<void> handleSubmit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      _showSnackBar();
      //
      //
      String username = 'prodhi18@gmail.com';
      String password = '025915jb';

      final smtpServer = gmail(username, password);

      final message = Message()
        ..from = Address(username, 'Your name')
        ..recipients.add('prodhi18@gmail.com')
        ..subject = 'নিম্নোক্ত ঋণগ্রহণে ইচ্ছুক গ্রাহকের সহিত যোগাযোগ করুন'
        ..html = "<div>"
            "<h1><b>নামঃ</b>${this.name}</h1>"
            "<div>"
            "<b>যোগাযোগঃ</b>${this.phone}<br>"
            "<b>স্মার্ট কার্ড/জাতীয় পরিচয়পত্র নংঃ</b>${this.nid}<br>"
            "<b>স্থায়ী ঠিকানাঃ</b>${this.peradd}<br>"
            "<b>বর্তমান ঠিকানাঃ</b>${this.peradd}<br>"
            "<b>লিঙ্গঃ</b>${this.gender}<br>"
            "<b>জন্মতারিখঃ</b>${this.bday}"
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
    print("Name is: ${this.name}");
    print("phone is: ${this.phone}");
    print("nid is: ${this.nid}");
    print("preadd is: ${this.preadd}");
    print("peradd is: ${this.peradd}");
    print("peradd is: ${this.gender}");
    print("date is: ${this.bday}");
  }

  @override
  Widget build(BuildContext context) {
    String _value = '--Select--';
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
                                return 'Please enter a valid type of business';
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

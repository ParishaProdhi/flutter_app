import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
// import 'package:sms/sms.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  var formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var name,
      phone,
      nid,
      bday,
      gender,
      div,
      dis,
      upa,
      uni,
      app_type,
      dep_type,
      dep_scheme_type,
      address = '',
      loan_type;

  List divisionList, districtList, upazillaList, unionList;

  var dep_loan = null, dep_scheme = null;

  String _gender_value = '--Select--',
      _type_value = '--Select--',
      dep_loan_value = '--Select--',
      dep_scheme_value = '--Select--';

  String _division = '0', _district = '0', _upazilla = '0', _union = '0';
  var a;
  void initState() {
    a = AssetImage('assets/images/back.jpg');
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
    String password = '2020|abc';

    final smtpServer = gmail(username, password);
    final branch_result = await http.get('http://b7e35dd4d94c.ngrok.io/branches/getEmailAddress/${this.uni}');
    final decoded_branch_result = jsonDecode(branch_result.body);
    final email_address = decoded_branch_result[0]["Email_address"].toString();
    final branch_name = decoded_branch_result[0]["BRANCH_NAME"].toString();
    print(email_address);
    print(branch_name);
    final message = Message()
      ..from = Address(username, 'Bangladesh Krishi Bank')
      ..recipients.add(email_address)
      ..subject = 'নিম্নোক্ত গ্রাহকের সহিত যোগাযোগ করুন'
      ..html =
          "<div>"
          "<div>"
          "<h1><b>${app_type == 'loan' ? 'ঋণগ্রহণে আগ্রহী' : 'আমানতপ্রদানে আগ্রহী'}</b></h1>"
          "<b>${app_type == 'loan' ? 'ঋণের ধরণঃ ' : 'আমানতের ধরণঃ '}</b>"
          "${app_type == 'loan' ? this.loan_type : this.dep_type}"
          "${app_type == 'dep' ? '(' + this.dep_scheme_type + ")" : ""}"
          "<br>"
          "<b>নামঃ </b>${this.name}<br>"
          "<b>যোগাযোগঃ </b>${this.phone}<br>"
          "<b>স্মার্ট কার্ড/জাতীয় পরিচয়পত্র নংঃ </b>${this.nid}<br>"
          "<b>ঠিকানাঃ </b>বিভাগ-${this.div}, জেলা-${this.dis}, উপজেলা-${this.upa}, ইউনিয়ন-${this.uni}<br>"
          "<b>লিঙ্গঃ </b>${this.gender}<br>"
          "<b>জন্মতারিখঃ </b>${this.bday}<br>"
          "<br>"
          "<form method='get' action='http://b7e35dd4d94c.ngrok.io/sendSMS/${this.phone}/$branch_name'>"
          "<label>গ্রাহক যে সময় পরিসরে আপনার ব্রাঞ্চে যোগাযোগ  করবেনঃ <input name='startDate' type='date'> থেকে <input name='endDate' type='date'></label>"
          "<input type='submit' value='গ্রাহককে জানান'>"
          "</form>"
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
  }


  // sendOTP() {
  //   SmsSender sender = new SmsSender();
  //   sender.sendSms(new SmsMessage(
  //       "+8801877424057", 'Your OTP is : '));
  // }
  Future<void> _saveToDB() async {
    var loan_type_check_null =
        (this.loan_type != null) ? this.loan_type : "not_applicable";
    var dep_type_check_null =
        (this.dep_type != null) ? this.dep_type : "not_applicable";
    var dep_scheme_type_check_null = (this.dep_scheme_type != null)
        ? this.dep_scheme_type
        : "not_applicable";
    final response =
        await http.post("https://b7e35dd4d94c.ngrok.io/post", body: {
      "name": this.name,
      "phone": this.phone,
      "nid": this.nid,
      "address": "ঠিকানাঃ " +
          this.div +
          ", জেলা-" +
          this.dis +
          ", উপজেলা-" +
          this.upa +
          ", ইউনিয়ন-" +
          this.uni,
      "bday": this.bday,
      "gender": this.gender,
      "app_type": this.app_type,
      "loan_type": loan_type_check_null,
      "dep_type": dep_type_check_null,
      "dep_scheme_type": dep_scheme_type_check_null
    });
  }

  Future<void> handleSubmit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      _showSnackBar();
      _saveToDB();
      _sendMail();
    }
  }

  Future<void> _getDivisionList() async {
    await rootBundle
        .loadString("assets/json/divisions.json")
        .then((responseDiv) {
      var dataReg = json.decode(responseDiv);

      setState(() {
        divisionList = dataReg;
      });
    });
  }

  Future<void> _getDistrictList(String _division) async {
    await rootBundle
        .loadString("assets/json/districts.json")
        .then((responseDis) {
      var dataDis = json.decode(responseDis);
      var appropriateDataDis = [];
      appropriateDataDis.add(dataDis[0]);
      int i;
      for (i = 1; i < dataDis.length; i++) {
        if (dataDis[i]["division_id"] == _division) {
          appropriateDataDis.add(dataDis[i]);
        }
      }
      setState(() {
        districtList = appropriateDataDis;
      });
    });
  }

  Future<void> _getUpazillaList(String _district) async {
    await rootBundle
        .loadString("assets/json/upazillas.json")
        .then((responseUpa) {
      var dataUpa = json.decode(responseUpa);
      var appropriateDataUpa = [];
      appropriateDataUpa.add(dataUpa[0]);
      int i;
      for (i = 1; i < dataUpa.length; i++) {
        if (dataUpa[i]["district_id"] == _district) {
          appropriateDataUpa.add(dataUpa[i]);
        }
      }
      setState(() {
        upazillaList = appropriateDataUpa;
      });
    });
  }

  Future<void> _getUnionList(String _upazilla) async {
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

  Widget _switch_dep_loan(String s) {
    print(s);
    switch (s) {
      case 'deposit':
        return Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
              child: SizedBox(
                width: 95,
                child: Text(
                  'আমানতের ধরণ',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Container(
              width: 220,
              child: DropdownButtonFormField<String>(
                isDense: false,
                itemHeight: 65,
                isExpanded: true,
                value: dep_loan_value,
                onChanged: (String value) {
                  setState(() {
                    dep_loan_value = value;
                    dep_scheme = value;
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
                      'Savings deposit Account',
                    ),
                    value: 'Savings deposit Account',
                  ),
                  DropdownMenuItem(
                    child: Text('Current Deposit Account'),
                    value: 'Current Deposit Account',
                  ),
                  DropdownMenuItem(
                    child: Text('Special Notice Deposit (SND) Account'),
                    value: 'Special Notice Deposit (SND) Account',
                  ),
                  DropdownMenuItem(
                    child: Text('Student Savings Account'),
                    value: 'Student Savings Account',
                  ),
                  DropdownMenuItem(
                    child: Text(
                        'Time Deposits (BKB own products) Monthly/Quarterly Benefit Scheme'),
                    value: 'time_deposits',
                  ),
                  DropdownMenuItem(
                    child: Text('Special Schemes'),
                    value: 'special_schemes',
                  ),
                ],
                onSaved: (value) {
                  this.dep_type = value;
                },
              ),
            ),
          ],
        );
      case 'loan':
        return Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
              child: SizedBox(
                width: 95,
                child: Text(
                  'ঋণের ধরণ',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Container(
              width: 220,
              child: DropdownButtonFormField<String>(
                isDense: false,
                itemHeight: 65,
                isExpanded: true,
                value: dep_loan_value,
                onChanged: (String value) {
                  setState(() {
                    dep_loan_value = value;
                    dep_scheme = value;
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
                      'Farm and Irrigation Equipment Loan',
                    ),
                    value: 'Farm and Irrigation Equipment Loan',
                  ),
                  DropdownMenuItem(
                    child: Text('Live Stock & Continuous Loan'),
                    value: 'Live Stock & Continuous Loan',
                  ),
                  DropdownMenuItem(
                    child: Text('Crop Loan'),
                    value: 'Crop Loan',
                  ),
                  DropdownMenuItem(
                    child: Text('SME'),
                    value: 'SME',
                  ),
                  DropdownMenuItem(
                    child: Text('Fisheries Loan'),
                    value: 'Fisheries Loan',
                  ),
                ],
                onSaved: (value) {
                  this.loan_type = value;
                },
              ),
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _switch_dep_scheme(String s) {
    print(s);
    switch (s) {
      case 'time_deposits':
        return Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
              child: SizedBox(
                width: 95,
                child: Text(
                  'Time Deposits (BKB own products) Monthly/Quarterly Benefit Scheme',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Container(
              width: 220,
              child: DropdownButtonFormField<String>(
                isDense: false,
                itemHeight: 65,
                isExpanded: true,
                value: dep_scheme_value,
                onChanged: (String value) {
                  setState(() {
                    dep_scheme_value = value;
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
                      'Fixed Deposit Receipt (FDR) Account',
                    ),
                    value: 'Fixed Deposit Receipt (FDR) Account',
                  ),
                  DropdownMenuItem(
                    child: Text('Small Savings Scheme'),
                    value: 'Small Savings Scheme',
                  ),
                  DropdownMenuItem(
                    child: Text('Education Savings Scheme'),
                    value: 'Education Savings Scheme',
                  ),
                ],
                onSaved: (value) {
                  this.dep_scheme_type = value;
                },
              ),
            ),
          ],
        );
      case 'special_schemes':
        return Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
              child: SizedBox(
                width: 95,
                child: Text(
                  'Special Schemes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Container(
              width: 220,
              child: DropdownButtonFormField<String>(
                isDense: false,
                itemHeight: 65,
                isExpanded: true,
                value: dep_scheme_value,
                onChanged: (String value) {
                  setState(() {
                    dep_scheme_value = value;
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
                      'BKB Monthly Profit Scheme',
                    ),
                    value: 'BKB Monthly Profit Scheme',
                  ),
                  DropdownMenuItem(
                    child: Text('BKB Double Profit Scheme'),
                    value: 'BKB Double Profit Scheme',
                  ),
                  DropdownMenuItem(
                    child: Text('BKB Quarterly Profit Scheme'),
                    value: 'BKB Quarterly Profit Scheme',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'BKB Monthly/Quarterly Profit Scheme',
                    ),
                    value: 'BKB Monthly/Quarterly Profit Scheme',
                  ),
                  DropdownMenuItem(
                    child: Text('Monthly Savings Scheme (MSS)'),
                    value: 'Monthly Savings Scheme (MSS)',
                  ),
                  DropdownMenuItem(
                    child: Text('BKB Millionaire Scheme'),
                    value: 'BKB Millionaire Scheme',
                  ),
                  DropdownMenuItem(
                    child: Text('BKB Monthly Deposit Scheme'),
                    value: 'BKB Monthly Deposit Scheme',
                  ),
                  DropdownMenuItem(
                    child: Text('BKB Lackpoti Scheme'),
                    value: 'BKB Lackpoti Scheme',
                  ),
                ],
                onSaved: (value) {
                  this.dep_scheme_type = value;
                },
              ),
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    bday = '';
    return Container(
        decoration: BoxDecoration(
            // color: Colors.white
            image: DecorationImage(
          image: a,
          fit: BoxFit.fill,
        )
        ),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text("প্রাথমিক তথ্যাবলী"),
            backgroundColor: Colors.transparent,
          ),
          body:
          SingleChildScrollView(
            
            child: Stack(children: <Widget>[
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
                          // autofocus: true,
                          onEditingComplete: () => node.nextFocus(), // Move focus to next
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
                          onEditingComplete: () => node.nextFocus(),
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
                            if (value.isEmpty)
                              return ("জাতীয় পরিচয়পত্র নং প্রদান আবশ্যক");
                            // if (value.length != 10)
                            //   return ("সঠিক তথ্য প্রদান করুন");
                          },
                          onSaved: (value) {
                            this.nid = value;
                          },
                          onEditingComplete: () => node.nextFocus(),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                            child: SizedBox(
                              width: 95,
                              child: Text(
                                'জন্মতারিখ ',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 94,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(labelText: 'YYYY'),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(4),
                              ],
                              onSaved: (value) {
                                this.bday = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) return ("আবশ্যক তথ্য");
                              },
                              onEditingComplete: () => node.nextFocus(),
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
                              onEditingComplete: () => node.nextFocus(),
                            ),
                          ),
                          Text('   '),
                          SizedBox(
                            width: 50,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(labelText: 'DD'),
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
                        ],
                      ),

                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                            child: SizedBox(
                              width: 90,
                              child: Text(
                                'ঠিকানা',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                width: 226,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value: _division,
                                  onChanged: (String value) {
                                    setState(() {
                                      _division = value;
                                      _getDistrictList(_division);
                                    });
                                  },

                                  hint: Text('Select Division'),
                                  items: divisionList?.map((item) {
                                        return DropdownMenuItem(
                                          child: Text(item['name']),
                                          value: item['id'].toString(),
                                        );
                                      })?.toList() ??
                                      [],
                                  onSaved: (value) {
                                    divisionList.forEach((p) {
                                      if (p["id"] == value) {
                                        this.div = p["name"];
                                      }
                                    });

                                    // divisionList[int.parse(value)]['name'];
                                    // this.address += "বিভাগঃ " + this.div + ", ";
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 216,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value: _district,
                                  onChanged: (String value) {
                                    setState(() {
                                      _district = value;
                                      _getUpazillaList(_district);
                                    });
                                  },
                                  hint: Text('Select District'),
                                  items: districtList?.map((item) {
                                        return new DropdownMenuItem(
                                          child: Text(item['name']),
                                          value: item['id'].toString(),
                                        );
                                      })?.toList() ??
                                      [],
                                  onSaved: (value) {
                                    districtList.forEach((p) {
                                      if (p["id"] == value) {
                                        this.dis = p["name"];
                                      }
                                    });
                                    // this.address += "জেলাঃ " + this.dis + ", ";
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 216,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value: _upazilla,
                                  onChanged: (String value) {
                                    setState(() {
                                      _upazilla = value;
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
                                    upazillaList.forEach((p) {
                                      if (p["id"] == value) {
                                        this.upa = p["name"];
                                      }
                                    });
                                    // this.address += "উপজেলাঃ " + this.uni + ", ";
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 216,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value: _union,
                                  onChanged: (String value) {
                                    setState(() {
                                      _union = value;
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
                                    unionList.forEach((p) {
                                      if (p["id"] == value) {
                                        this.uni = p["name"];
                                      }
                                    });
                                    // this.address += "ইউনিয়নঃ " + this.uni + ".";
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                            child: SizedBox(
                              width: 95,
                              child: Text(
                                'লিঙ্গ',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Container(
                            width: 220,
                            // width: 200,
                            // height: 200,
                            child: DropdownButtonFormField<String>(
                              value: _gender_value,
                              onChanged: (String value) {
                                setState(() {
                                  _gender_value = value;
                                });
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'আবশ্যক তথ্য';
                                }
                              },
                              items: [
                                DropdownMenuItem(
                                  child: Text('--Select Gender--'),
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
                                if (value == 'পুরুষ')
                                  this.gender = 'male';
                                else if (value == 'মহিলা')
                                  this.gender = 'female';
                                else
                                  this.gender = 'others';
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
                              width: 95,
                              child: Text(
                                'আবেদনের ধরণ',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Container(
                            width: 220,
                            // width: 200,
                            // height: 200,
                            child: DropdownButtonFormField<String>(
                              value: _type_value,
                              onChanged: (String value) {
                                setState(() {
                                  _type_value = value;
                                  dep_loan = _type_value;
                                });
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'আবশ্যক তথ্য';
                                }
                              },
                              items: [
                                DropdownMenuItem(
                                  child: Text('--Select Type--'),
                                  value: '--Select--',
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    'আমানত',
                                  ),
                                  value: 'deposit',
                                ),
                                DropdownMenuItem(
                                  child: Text('ঋণ'),
                                  value: 'loan',
                                ),
                              ],
                              onSaved: (value) {
                                this.app_type = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      _switch_dep_loan(dep_loan),
                      _switch_dep_scheme(dep_scheme),
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
          ),
        ));
  }
}

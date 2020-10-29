import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  var formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var nameCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();
  var nidCtrl = TextEditingController();
  var bdayCtrl = TextEditingController();
  var sexCtrl = TextEditingController();
  var preaddCtrl = TextEditingController();
  var peraddCtrl = TextEditingController();

  var name, phone, nid, bday, sex, preadd, peradd;

  _showSnackBar() {
    var _mySnackBar = SnackBar(content: Text("vfvjjhjvb"));
    _scaffoldKey.currentState.showSnackBar(_mySnackBar);
  }

  void handleSubmit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      _showSnackBar();
      //todo
    }
    print("Name is: ${this.name}");
    print("phone is: ${this.phone}");
    print("nid is: ${this.nid}");
    print("preadd is: ${this.preadd}");
    print("peradd is: ${this.peradd}");
  }

  // void handleReset() {
  //   nameCtrl.clear();
  //   phoneCtrl.clear();
  //   addressCtrl.clear();
  // }

  @override
  Widget build(BuildContext context) {
    DateTime _dateTime;

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
                    TextFormField(
                      controller: nameCtrl,
                      decoration: InputDecoration(labelText: 'নাম'),
                      validator: (value) {
                        if (value.isEmpty) return ("নাম প্রদান আবশ্যক");
                      },
                      onSaved: (value) {
                        this.name = value;
                      },
                    ),
                    TextFormField(
                      controller: phoneCtrl,
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
                    TextFormField(
                      controller: nidCtrl,
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
                    TextFormField(
                      controller: preaddCtrl,
                      decoration: InputDecoration(labelText: 'বর্তমান ঠিকানা'),
                      validator: (value) {
                        if (value.isEmpty) return ("আবশ্যক তথ্য");
                      },
                      onSaved: (value) {
                        this.preadd = value;
                      },
                    ),
                    TextFormField(
                      controller: peraddCtrl,
                      decoration: InputDecoration(labelText: 'স্থায়ী ঠিকানা'),
                      validator: (value) {
                        if (value.isEmpty) return ("আবশ্যক তথ্য");
                      },
                      onSaved: (value) {
                        this.peradd = value;
                      },
                    ),

                    // Row(
                    //   children: <Widget>[
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

                    // RaisedButton(
                    //   color: Colors.orange,
                    //   child: Text('Reset'),
                    //   onPressed: handleReset,
                    // )
                    // ],
                    // )
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}

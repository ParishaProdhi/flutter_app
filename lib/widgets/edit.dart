import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String _myActivity;
  String _myActivityResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(color: Colors.transparent),
      child: DropDownFormField(
        titleText: 'লিঙ্গ',
        hintText: 'নির্বাচন করে দিন‍',
        value: _myActivity,
        onSaved: (value) {
          setState(() {
            _myActivity = value;
            print(_myActivity);
          });
        },
        onChanged: (value) {
          setState(() {
            _myActivity = value;
          });
        },
        dataSource: [
          {
            "display": "Male",
            "value": "Male",
          },
          {
            "display": "Female",
            "value": "Female",
          },
          {
            "display": "Others",
            "value": "Others",
          },
        ],
        textField: 'display',
        valueField: 'value',
      ),
    );
  }
}
